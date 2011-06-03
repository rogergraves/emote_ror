# == Schema Information
# Schema version: 20110228231111
#
# Table name: surveys
#
#  id              :integer(4)      not null, primary key
#  user_id         :integer(4)
#  project_name    :string(255)     not null
#  score           :float           default(0.0)
#  responses_count :integer(4)      default(0)
#  public          :boolean(1)      default(FALSE)
#  created_at      :datetime
#  updated_at      :datetime
#  code            :string(20)      not null
#  action_token    :string(255)
#  state           :integer(4)      default(0), not null
#  scorecard_code  :string(20)      not null
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
  
  has_many :survey_results, :foreign_key => :code, :primary_key => :code
  
  validates :user, :presence => true
  validates :project_name, :presence => true, :uniqueness => {:scope => :user_id}, :length => { :maximum => 255 }
  validates :code, :presence => true, :uniqueness => true, :length => { :maximum => 20 }
  validates :state, :inclusion => { :in => [STATE_ACTIVE, STATE_ARCHIVED, STATE_SUSPENDED] }

  alias_attribute :public_scorecard, :public 
  alias_attribute :short_stimulus, :project_name
  attr_accessible :project_name, :user_id, :state, :code
  
  after_save do
    survey_xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
    <survey status='#{ (self.active?) ? 'on' : 'off' }'>
    <stimulus short=\"#{self.project_name}\"><![CDATA[Consider every aspect of your most recent experience with <span class=\"bold-text\">#{self.project_name}</span>.
    What was that like for you? How would you describe your feelings about this experience to someone else?]]></stimulus>
      <thanks>Thank you for e.moting!</thanks>
    </survey>"
    File.open("#{SURVEY_STORAGE_PATH}#{self.code}.xml", 'w') {|f| f.write(survey_xml) }
  end
  
  before_destroy do
    begin
      File.delete("#{SURVEY_STORAGE_PATH}#{self.code}.xml")
    rescue
      #TODO i'm sleeping, need to add something here later
    end
  end
  
  before_validation(:on => :create) do
    generate_code!('code') if self.code.blank?
    generate_code!('scorecard_code') if self.scorecard_code.blank?
  end

  before_validation do
    self.code.upcase! if self.code_changed?
  end

  validate(:on => :create) do |survey|
    if !survey.user(true).can_add_scorecard? && !@force_creation
      survey.errors[:user] = ' cannot add more e.motes'
    end
  end

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

  def generate_action_token!
    self.action_token = Digest::MD5.hexdigest("#{id}-==-#{code}-=-#{Time.now}")
  end

  def new_responses_count(refresh = false)
    @new_responses_count = nil if refresh
    @new_responses_count ||= Survey.connection.select_value(<<-SQL
        SELECT count(*) FROM survey_result AS sr
          INNER JOIN surveys AS s ON s.code=sr.code
          WHERE s.id=#{self.id} AND sr.is_removed=0 AND sr.end_time >= '#{self.scorecard_viewed_at.to_s(:db)}';
      SQL
    )
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
