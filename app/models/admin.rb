class Admin < ActiveRecord::Base
  #Refer to https://github.com/plataformatec/devise/wiki/How-To:-Add-an-Admin-role

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable, :registerable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :user_notes, :as => :creator, :class_name => 'Note'

end