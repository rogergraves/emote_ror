class PaypalTransaction < ActiveRecord::Base
  belongs_to  :user
  belongs_to  :subscription
  
  validates :user, :presence => true
  validates :subscription, :presence => true
  validates :total, :presence => true, :numericality => true
  validates :token, :presence => true
  validates :customer_email, :presence => true
end
