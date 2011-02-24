# == Schema Information
# Schema version: 20110220073519
#
# Table name: users
#
#  id                   :integer(4)      not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer(4)      default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  full_name            :string(100)
#  country_code         :string(20)
#  company              :string(60)
#  job_title            :string(60)
#  phone_number         :string(25)
#  created_at           :datetime
#  updated_at           :datetime
#  confirmation_token   :string(255)
#  confirmed_at         :datetime
#  confirmation_sent_at :datetime
#  banned               :boolean(1)      default(FALSE)
#  surveys_count        :integer(4)      default(0)
#  subscriptions_count  :integer(4)      default(0)
#

class User < ActiveRecord::Base
  has_many :surveys, :dependent => :destroy
  has_many :subscriptions, :dependent => :destroy

  has_many :admin_notes, :as => :subject, :class_name => 'Note', :dependent => :destroy

  cattr_reader :per_page
  @@per_page = 50

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :full_name, :country_code, :company, :job_title, :phone_number, :tos_agree, :banned

  validates :email, :length => { :maximum => 255 }, :uniqueness => true
  validates :full_name, :length => { :maximum => 100 }
  validates :job_title, :length => { :maximum => 60 }
  validates :phone_number, :length => { :maximum => 25 }

  attr_accessor :tos_agree
  validates :tos_agree, :acceptance => {:on => :create}

  before_create do |user|
    free_trial = Subscription.new(:emote_amount => 1, :start_date => DateTime.now)
    free_trial.trial = true
    user.subscriptions << free_trial
  end
  
  def current_subscriptions
    subscriptions.select(&:active?)
  end

  # Total emote slots including active and outdated
  def scorecards_total
    subscriptions.map(&:emote_amount).sum
  end
  
  # Slots occupied by emotes
  def scorecards_used
    surveys.count
  end
  
  # Number of paid active (non-occupied) slots
  def scorecards_available
    current_subscriptions.map(&:emote_amount).sum - scorecards_used
  end
  
  def can_add_scorecard?
    scorecards_available > 0
  end
  
end
