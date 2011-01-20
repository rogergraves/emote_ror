# == Schema Information
# Schema version: 20110118230554
#
# Table name: subscriptions
#
#  id           :integer(4)      not null, primary key
#  user_id      :integer(4)
#  emote_amount :integer(4)      default(0)
#  created_at   :datetime
#  updated_at   :datetime
#

class Subscription < ActiveRecord::Base

  KIND_REGULAR = 0
  KIND_TRIAL = 1
  
  belongs_to :user
  has_one :transaction, :class_name => 'PaypalTransaction', :foreign_key => 'subscription_id'

  validates :user, :presence => true
  validates :emote_amount, :presence => true, :numericality => true, :inclusion => {:in => [1, 5, 10, 25]}

  validate do |subscription|
    errors.add(:base, ' end_date should be after start_date') if subscription.end_date <= subscription.start_date
    errors.add(:base, ' trial is longer than 30 days') if subscription.trial? && subscription.end_date > 30.days.since(subscription.start_date)
    errors.add(:base, ' regular is longer than 1 year') if !subscription.trial? && subscription.end_date > 1.year.since(subscription.start_date)
  end

  def active?
    (start_date..end_date) === DateTime.now
  end

  def trial?
    kind == KIND_TRIAL
  end

  def trial=(val)
    if val
      self.kind = KIND_TRIAL
      self.end_date = 30.days.since(start_date)
    else
      self.kind = KIND_REGULAR
      self.end_date = 1.year.since(start_date)
    end
    true
  end

end
