# == Schema Information
# Schema version: 20110220073519
#
# Table name: subscriptions
#
#  id               :integer(4)      not null, primary key
#  user_id          :integer(4)
#  emote_amount     :integer(4)      default(0)
#  created_at       :datetime
#  updated_at       :datetime
#  start_date       :datetime        not null
#  end_date         :datetime        not null
#  kind             :integer(4)      default(0), not null
#  token            :string(255)
#  purchase_date    :datetime
#  total_paid       :float           default(0.0), not null
#  customer_name    :string(255)
#  customer_id      :string(32)
#  customer_address :string(255)
#  customer_email   :string(255)
#  customer_phone   :string(50)
#  description      :string(255)
#  product_code     :string(64)
#  currency         :string(10)      default("USD")
#

class Subscription < ActiveRecord::Base
  
  OPTIONS = [
              {
                :prod_code => 'a135b60381e3903405b02ee571ecff66', # Digest::MD5.hexdigest("1 Pack")
                :amount => 1,
                :name => "1 e.mote™",
                :price => 99
              },
              {
                :prod_code => '72aaa7938815a1268fa642468b6ae7bc',
                :amount => 5,
                :name => "5 e.motes™",
                :price => 299
              },
              {
                :prod_code => '25ccaa6255d6112a0d7a39054feb6d2f',
                :amount => 10,
                :name => "10 e.motes™",
                :price => 499
              },
              {
                :prod_code => '3384de5df97bf2e2535f101329649119',
                :amount => 25,
                :name => "25 e.motes™",
                :price => 999
              }
            ]
  
  KIND_REGULAR = 0
  KIND_TRIAL = 1
  
  belongs_to :user, :counter_cache => true

  validates :user, :presence => true
  validates :emote_amount, :presence => true, :numericality => true #, :inclusion => {:in => [-1, -5, -10, -25, 0, 1, 5, 10, 25]}
  
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :purchase_date, :presence => true

  validate do |subscription|
    errors.add(:base, 'end_date should be after start_date') if subscription.end_date <= subscription.start_date
    errors.add(:base, 'Trial cannot be longer than 30 days') if subscription.trial? && subscription.end_date > 30.days.since(subscription.start_date)
    errors.add(:base, 'Trial is restricted to 1 emote') if subscription.trial? && subscription.emote_amount != 1
    errors.add(:emote_amount, ' must be other than zero') if subscription.emote_amount.zero?
  end

  def active?
    (start_date..end_date) === DateTime.now
  end

  def trial?
    kind == KIND_TRIAL
  end

  def trial=(val)
    self.purchase_date = DateTime.now
    if val
      self.kind = KIND_TRIAL
      self.emote_amount = 1
      self.end_date = 30.days.since(start_date) if start_date?
      self.token = 'FREE TRIAL'
    else
      self.kind = KIND_REGULAR
      self.end_date = 1.year.since(start_date) if start_date?
    end
    true
  end

end
