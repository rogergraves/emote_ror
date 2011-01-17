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
end
