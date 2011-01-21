# == Schema Information
# Schema version: 20110119224018
#
# Table name: subscriptions
#
#  id           :integer(4)      not null, primary key
#  user_id      :integer(4)
#  emote_amount :integer(4)      default(0)
#  created_at   :datetime
#  updated_at   :datetime
#  start_date   :datetime        not null
#  end_date     :datetime        not null
#  kind         :integer(4)      default(0), not null
#

class Subscription < ActiveRecord::Base
  
  OPTIONS = [
              {
                :amount => 1,
                :name => "1 Pack",
                :price => 99,
                :short_desc => 'Add 1 ScoreCard to your account for 12 months.',
                :long_desc => 'Average cost is $8.25 per ScoreCard per month.',
                :savings => ""
              },
              {
                :amount => 5,
                :name => "5 Pack",
                :price => 299,
                :short_desc => 'Add 5 ScoreCards to your account for 12 months.',
                :long_desc => 'Average cost is $5 per ScoreCard per month.',
                :savings => "$196 / year."
              },
              {
                :amount => 10,
                :name => "10 Pack",
                :price => 399,
                :short_desc => 'Add 10 ScoreCards to your account for 12 months.',
                :long_desc => 'Average cost is $3.30 per ScoreCard per month.',
                :savings => "$590 / year."
              },
              {
                :amount => 25,
                :name => "25 Pack",
                :price => 499,
                :short_desc => 'Add 25 ScoreCards to your account for 12 months.',
                :long_desc => 'Average cost is $1.75 per ScoreCard per month.',
                :savings => "$1975 / year."
              }
            ]
  
  KIND_REGULAR = 0
  KIND_TRIAL = 1
  
  belongs_to :user
  has_one :transaction, :dependent => :nullify, :class_name => 'PaypalTransaction', :foreign_key => 'subscription_id'

  validates :user, :presence => true
  validates :emote_amount, :presence => true, :numericality => true, :inclusion => {:in => [1, 5, 10, 25]}
  
  validates :start_date, :presence => true
  validates :end_date, :presence => true

  validate do |subscription|
    errors.add(:base, ' end_date should be after start_date') if subscription.end_date <= subscription.start_date
    errors.add(:base, ' trial is longer than 30 days') if subscription.trial? && subscription.end_date > 30.days.since(subscription.start_date)
    errors.add(:base, ' regular is longer than 1 year') if !subscription.trial? && subscription.end_date > 1.year.since(subscription.start_date)
    errors.add(:base, ' trial is restricted to 1 emote') if subscription.trial? && subscription.emote_amount != 1
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
