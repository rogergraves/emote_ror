class User < ActiveRecord::Base
  REPORT_INTERVAL_OPTIONS = %w(none daily weekly monthly)

  has_many :surveys, :dependent => :destroy
  has_one :plan, :dependent => :destroy, :class_name => 'Subscription'
  has_many :payments, :dependent => :destroy

  has_many :admin_notes, :as => :subject, :class_name => 'Note', :dependent => :destroy

  cattr_reader :per_page
  @@per_page = 50

  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :partner_code,
                  :full_name, :country_code, :company, :job_title, :phone_number, :tos_agree, :banned

  validates :email, :length => { :maximum => 255 }
  validates :full_name, :length => { :maximum => 100 }
  validates :job_title, :length => { :maximum => 60 }
  validates :phone_number, :length => { :maximum => 25 }
  validates :activity_report_interval, :inclusion => REPORT_INTERVAL_OPTIONS

  attr_accessor :tos_agree
  validates :tos_agree, :acceptance => {:on => :create}

  before_create do |user|
    user.build_plan(:kind => 'free', :emote_amount => 1, :start_date => DateTime.now, :end_date => 50.years.from_now)
    user.payments.build(:source => 'auto', :purchase_date => DateTime.now, :total_paid => 0, :description => 'Free e.mote&reg;')
  end

  def name
    full_name.blank? ? email : full_name
  end

  # Total emote slots including active and outdated
  def scorecards_total
    plan.emote_amount
  end

  # Slots occupied by emotes
  def scorecards_used
    surveys.count
  end

  # Number of paid active (non-occupied) slots
  def scorecards_available
    scorecards_total - scorecards_used
  end

  def can_add_scorecard?
    scorecards_available > 0
  end

end