# == Schema Information
# Schema version: 20110220073519
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
#

class Survey
  include Mongoid::Document
  
  field :user_id, :type => Integer
  field :project_name, :type => String
  field :score, :type => Float, :default => 0.0
  field :responses_count, :type => Integer, :default => 0
  field :public, :type => Boolean, :default => true
  field :code, :type => String
  index :code, :unique => true
  field :action_token, :type => String
  field :state, :type => Integer, :default => 0
  field :created_at, :type => DateTime
  field :updated_at, :type => DateTime

  references_many :survey_responses, :dependent => :destroy

  def user(reload = false)
    @user_assoc = nil if reload
    @user_assoc ||= User.find(user_id)
  end

  #belongs_to :user, :counter_cache => true
  #has_many :survey_results, :foreign_key => :code, :primary_key => :code

  
  require 'zlib'

  STATE_ACTIVE = 0
  STATE_ARCHIVED = 1
  STATE_SUSPENDED = 2
  
  cattr_reader :per_page
  @@per_page = 50
  
  attr_accessor :force_creation
  @force_creation = false
  
  validates :user, :presence => true
  validates :project_name, :presence => true, :uniqueness => {:scope => :user_id}, :length => { :maximum => 255 }
  validates :code, :presence => true, :uniqueness => true, :length => { :maximum => 20 }
  validates :state, :inclusion => { :in => [STATE_ACTIVE, STATE_ARCHIVED, STATE_SUSPENDED] }

  alias_attribute :public_scorecard, :public 
  alias_attribute :short_stimulus, :project_name
  attr_accessible :project_name, :user_id, :state, :code
  
  before_validation(:on => :create) do
    generate_survey_code! if self.code.blank?
  end

  before_validation do
    self.code.upcase! if self.code_changed?
  end

  validate(:on => :create) do |survey|
    if false && !survey.user(true).can_add_scorecard? && !@force_creation #FIXME ar bounds
      survey.errors[:user] = ' cannot add more e.motes'
    end
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

  def scorecard_embed_link
    "<iframe src='#{emote_direct_link}'/>" #Approx.
  end

  def generate_action_token!
    self.action_token = Digest::MD5.hexdigest("#{id}-==-#{code}-=-#{Time.now}")
  end

protected

  def generate_survey_code!
    i = 0; kukan = 'x'
    loop do
      kukan = Zlib::crc32("#{self.user ? self.user.full_name : 'no_user'}-#{self.user_id}--#{self.id}-#{self.project_name}-=-[OMATORE]-=#{i}=-#{Time.now.to_i}").to_s(36).upcase
      break kukan unless Survey.find(:first, :conditions => { :code => kukan })
      i+=1
    end
    self.code = kukan
  end

end
