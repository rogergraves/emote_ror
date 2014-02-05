class Payment < ActiveRecord::Base
  belongs_to :user


  PAYMENT_SOURCES = %w( paypal offline auto)

  validates :source, :inclusion => PAYMENT_SOURCES, :presence => true
  validates :total_paid, :presence => true
  validates :description, :presence => true

  def paid_online?
    source != 'offline'
  end

end