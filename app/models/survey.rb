# == Schema Information
# Schema version: 20110620133338
#
# Table name: surveys
#
#  id                        :integer(4)      not null, primary key
#  user_id                   :integer(4)
#  project_name              :string(255)     not null
#  score                     :float           default(0.0)
#  responses_count           :integer(4)      default(0)
#  public                    :boolean(1)      default(FALSE)
#  created_at                :datetime
#  updated_at                :datetime
#  code                      :string(20)      not null
#  action_token              :string(255)
#  state                     :integer(4)      default(0), not null
#  scorecard_code            :string(20)      not null
#  activated_at              :datetime
#  scorecard_viewed_at       :datetime
#  store_respondent_contacts :boolean(1)      default(FALSE)
#  feedback_prompt           :string(255)     default("")
#

class Survey < ActiveRecord::Base
  require 'zlib'

  STATE_ACTIVE = 0
  STATE_ARCHIVED = 1
  STATE_SUSPENDED = 2
  
  cattr_reader :per_page
  @@per_page = 50
  
  attr_accessor :force_creation
  @force_creation = false
  
  belongs_to :user, :counter_cache => true
  
  has_many :visible_responses, :class_name => 'SurveyResult', :foreign_key => :code, :primary_key => :code, :conditions => {:is_removed => false}, :order => '`start_time` ASC'
  has_many :all_responses, :class_name => 'SurveyResult', :foreign_key => :code, :primary_key => :code
  
  validates :user, :presence => true
  validates :project_name, :presence => true, :uniqueness => {:scope => :user_id}, :length => { :maximum => 200 }
  validates :code, :presence => true, :uniqueness => true, :length => { :maximum => 20 }
  validates :state, :inclusion => { :in => [STATE_ACTIVE, STATE_ARCHIVED, STATE_SUSPENDED] }

  alias_attribute :public_scorecard, :public 
  alias_attribute :short_stimulus, :project_name
  attr_accessible :project_name, :user_id, :state, :code, :store_respondent_contacts, :feedback_prompt
  
  before_destroy do
    begin
      File.delete(qrcode_file)
    rescue
      #TODO i'm sleeping, need to add something here later
    end
  end
  
  before_validation(:on => :create) do |survey|
    generate_code!('code') if survey.code.blank?
    generate_code!('scorecard_code') if survey.scorecard_code.blank?
    survey.scorecard_viewed_at = survey.activated_at = DateTime.now
    make_qrcode!
  end

  before_validation do
    if self.code_changed?
      self.code.upcase! 
      self.make_qrcode!
    end
  end

  validate(:on => :create) do |survey|
    if !survey.user(true).can_add_scorecard? && !@force_creation
      survey.errors[:user] = ' cannot add more e.motes'
    end
  end

  def visible_responses_with_limit
    if self.user.plan.is_free?
      self.visible_responses_without_limit.limit(10)
    else
      self.visible_responses_without_limit
    end
  end
  alias_method_chain :visible_responses, :limit

  before_save do |survey|
    survey.activated_at = DateTime.now if survey.state_changed? && survey.state == STATE_ACTIVE
  end

  def active?
    state==STATE_ACTIVE
  end

  def archived?
    state==STATE_ARCHIVED
  end

  def suspended?
    state==STATE_SUSPENDED
  end

  def state_human
    %w(Active Archived Suspended)[state]
  end

  def emote_direct_link
    "http://emotethis.com/#{self.code}" # http://www.emotethis.com/browser/index.php?survey=#{self.code}
  end
  
  def self.qrcode_file_path(survey_code)
    File.join(Rails.root, 'public', 'images', 'qr', "emote_#{survey_code}_qr.png")
  end
  
  def qrcode_file
    self.class.qrcode_file_path(self.code)
  end

  def qrcode_url
    "qr/emote_#{self.code}_qr.png"
  end
  
  def make_qrcode!
    old_qr = self.class.qrcode_file_path(self.code_was)
    File.delete(old_qr) if File.exists?(old_qr)
    qr_url = "http://chart.googleapis.com/chart?cht=qr&chs=200x200&chl=#{URI.escape(self.emote_direct_link)}"
    File.open(qrcode_file, 'wb') do |qr_file|
      png = Net::HTTP.get_response(URI.parse(qr_url))
      qr_file.write png.body
    end
  end

  def generate_action_token!
    self.action_token = Digest::MD5.hexdigest("#{id}-==-#{code}-=-#{Time.now}")
  end
  
  def result_obj
    score, total_emotions, pp_intensities = 0, 0, 0
    pie_data = {:pp => 0, :mp => 0, :pn => 0, :mn => 0}
    emotions = SurveyResult::EMOTIONS.map {|k,v| {:value => 0, :name => k, :type => v, :color => ( (v == :positive) ? 'green' : 'red' )} }
    
    visible_responses.each do |res|
      emote = emotions.select {|e| e[:name] == res.emote }.first
      
      barometer_key = SurveyResult.barometer_category_from_intensity(emote[:name], res.intensity_level)
      pie_data[barometer_key] += 1
      pp_intensities += res.intensity_level if barometer_key==:pp
			emote[:value] += 1
			total_emotions += 1
    end
    emotions.sort! {|a,b| b[:value]<=>a[:value] }
    score = (pp_intensities/pie_data[:pp]).to_i rescue 0
    
    { :bars => emotions, :pie => pie_data, :totals => {:score => score, :total => total_emotions} }
  end
  
  def verbatims_obj(filter_str = '', emotion = '', grouping = nil, is_public = true)
    # ('id'=> '875', 'face'=> 'uneasy_intensity_1', 'timestamp'=> '03 Jun', 'text'=> 'test1'),
    verbs = []
    conditions = []
    unless filter_str.blank?
      conditions << SurveyResult.sql_condition(["`verbatim` like ?", "%#{filter_str}%"])
    end
    unless emotion.blank?
      conditions << SurveyResult.sql_condition(:emote => emotion)
    end
  
    visible_responses.where(conditions.join(' AND ')).order('`start_time` DESC').each do |res|
      intensity_level = 1
			if res['intensity_level'] >= 33 && res['intensity_level'] < 66
				intensity_level = 2
			elsif res['intensity_level'] >= 66
				intensity_level = 3
			end
			
			add_to_list = true
			unless grouping.blank?
			  
			  if res['intensity_level'] < 34
           category = "indifferent"
        elsif res['intensity_level'] < 66
           category = "participants"
        elsif SurveyResult.positives.include?(res['emote'])
           category = "enthusiasts"
        else
           category = "detractors"
        end
        
        add_to_list = (category == grouping)
			end
			if add_to_list
        obj = { :id => res.survey_result_id, :face => "#{res.emote}_intensity_#{intensity_level}", :timestamp => res.start_time.strftime("%d %b"), 'text'=> res.verbatim.gsub(/#{filter_str}/, "<b>#{filter_str}</b>") }
        if !is_public
          obj[:email] = res.email
          obj[:email_used] = res.email_used
        end
        verbs << obj
      end
    end
    verbs
  end

  def new_responses_count(opts = {})
    refresh = opts[:refresh] || false
    since = opts[:since] || self.scorecard_viewed_at
    @new_responses_count = nil if refresh
    @new_responses_count ||= self.visible_responses.where("`end_time` > ?", since).count
  end

#protected

  def generate_code!(field)
    i = 0; kukan = 'x'
    loop do
      kukan = Zlib::crc32("#{self.user ? self.user.full_name : 'no_user'}-#{self.user_id}--#{self.id}-#{self.project_name}-=-[OMATORE]-=#{i}=-#{Time.now.to_i}--#{field}").to_s(36).upcase
      break kukan unless Survey.find(:first, :conditions => { field.to_sym => kukan })
      i+=1
    end
    self.send("#{field}=", kukan)
  end

end
