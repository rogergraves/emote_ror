# == Schema Information
# Schema version: 20110118230554
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
#  first_name           :string(60)
#  last_name            :string(60)
#  country_code         :string(20)
#  company              :string(60)
#  job_title            :string(60)
#  phone_number         :string(25)
#  cell_number          :string(25)
#  created_at           :datetime
#  updated_at           :datetime
#

class User < ActiveRecord::Base
  has_many :surveys
  has_many :subscriptions
  has_many :transactions, :class_name => 'PaypalTransaction', :foreign_key => 'user_id'


  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
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
