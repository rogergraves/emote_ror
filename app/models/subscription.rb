class Subscription < ActiveRecord::Base
  belongs_to :user
  has_one :transaction, :class_name => 'PaypalTransaction', :foreign_key => 'subscription_id'

  validates :user, :presence => true
  validates :emote_amount, :presence => true, :numericality => true, :inclusion => {:in => [1, 5, 10, 25]}

  alias_attribute :starts, :created_at
  def ends
    1.year.since(starts)
  end

  def active?
    (starts..ends) === DateTime.now
  end

end
