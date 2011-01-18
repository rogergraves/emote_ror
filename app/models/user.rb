class User < ActiveRecord::Base
  has_many :surveys
  has_many :subscriptions
  has_one :transactions, :class_name => 'PaypalTransaction', :foreign_key => 'user_id'


  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :country_code, :company,
                  :job_title, :phone_number, :cell_number

  
  ## Total emote slots including active and outdated
  def emote_slots_total
    subscriptions.map(&:emote_amount).sum
  end
  
  ## Slots occupied by active emotes
  def emote_slots_used
    surveys.select(&:active).count
  end
  
  ## Number of paid active (non-occupied) slots
  def emote_slots_available 
    subscriptions.select(&:active?).map(&:emote_amount).sum - emote_slots_used
  end
  
  def can_add_emote?
    emote_slots_available > 0
  end
  

end
