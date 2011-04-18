# == Schema Information
# Schema version: 20110417191406
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
#  kind         :string(255)     not null
#

class Subscription < ActiveRecord::Base #aka Plan
  
  OPTIONS = [
              {
                :kind => 'free',
                :amount => 1,
                :name => "Free"
              },
              {
                :kind => 'start',
                :amount => 2,
                :name => "Start"
              },
              {
                :kind => 'expand',
                :amount => 10,
                :name => "Expand"
              },
              {
                :kind => 'magnify',
                :amount => 25,
                :name => "Magnify"
              }
            ]
            
  PLAN_KINDS = OPTIONS.map{|o| o[:kind] } << 'custom'
  
  belongs_to :user, :counter_cache => true

  validates :user, :presence => true
  validates :emote_amount, :presence => true, :numericality => true
  
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :kind, :inclusion => {:in => PLAN_KINDS}

  validate do |subscription|
    errors.add(:base, 'end_date should be after start_date') if subscription.end_date <= subscription.start_date
    errors.add(:emote_amount, ' must be other than zero') if subscription.emote_amount.zero?
    if opt_hash = OPTIONS.select{|o| o[:kind]==subscription.kind }.first
      errors.add(:base, "#{opt_hash[:name]} plan is restricted to #{opt_hash[:amount]} emote(s)") unless subscription.emote_amount == opt_hash[:amount]
    end
  end

  def active?
    (start_date..end_date) === DateTime.now
  end

  def is_free?
    kind == 'free'
  end

  def is_custom?
    kind == 'custom'
  end

  def human_name
    opt_hash = OPTIONS.select{|o| o[:kind]==kind }.first
    opt_hash.nil? ? 'Custom' : opt_hash[:name]
  end

  def can_upgrade_to?(plan_code)
    !!calc_upgrade_price(plan_code)
  end

  def upgrade!(new_plan_code)
    self.start_date = DateTime.now
    self.end_date = 1.year.since(self.start_date)
    self.kind = new_plan_code
    info = self.class.get_plan_hash(new_plan_code)
    self.emote_amount = info[:amount]
  end
  
  def self.get_plan_hash(plan_code, most_expensive_as_default = false)
    Subscription::OPTIONS.select{|s| s[:kind] == plan_code}.first || (most_expensive_as_default ? Subscription::OPTIONS.last : nil)
  end
  
  def calc_upgrade_price(new_plan_code)
    today = Date.today
    future = self.end_date
    months_left = ((future.year-today.year)*12 + future.month) - today.month
    return nil unless (0..12) === months_left
    if self.kind=='custom'
      nil
    elsif self.kind=='free'
      case new_plan_code
       when 'start' then 588
       when 'expand' then 1788
       when 'magnify' then 2388
       else nil
      end
    elsif self.kind=='start' && new_plan_code=='expand'
      1788 - (months_left * 49)
    elsif self.kind=='start' && new_plan_code=='magnify'
      2388 - (months_left * 49)
    elsif self.kind=='expand' && new_plan_code=='magnify'
      2388 - (months_left * 149)
    else
      nil
    end
  end

end
