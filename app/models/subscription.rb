class Subscription < ActiveRecord::Base #aka Plan

  OPTIONS = [
      {
          :kind => 'free',
          :amount => 10, # updated amount so free offers 10 e.motes to start vs. 1 previously - based on discussions with Steve, Roger, Jeb, Elena
          :name => "Free",
          :monthly_fee => 0
      },
      {
          :kind => 'start',
          :amount => 25,
          :name => "Start",
          :monthly_fee => 49
      },
      {
          :kind => 'expand',
          :amount => 100,
          :name => "Expand",
          :monthly_fee => 149
      },
      {
          :kind => 'magnify',
          :amount => 250,
          :name => "Magnify",
          :monthly_fee => 199
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
    opt_hash = self.class.get_plan_hash(kind)
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
    self.save
  end

  def self.get_plan_hash(plan_code, most_expensive_as_default = false)
    OPTIONS.select{|s| s[:kind] == plan_code}.first || (most_expensive_as_default ? OPTIONS.last : nil)
  end

  def self.static_monthly_fee(plan_kind)
    if plan_hsh = self.get_plan_hash(plan_kind)
      plan_hsh[:monthly_fee]
    else
      nil
    end
  end

  def static_monthly_fee
    self.class.static_monthly_fee(self.kind)
  end

  def months_left
    today = Date.today
    future = self.end_date
    ((future.year-today.year)*12 + future.month) - today.month
  end

  def annual_credit
    months_left * static_monthly_fee
  end

  def calc_upgrade_price(new_plan_code)
    #return nil unless (0..12) === months_left #Free account now lasts for tens of years
    return nil if (self.kind=='custom') || (new_plan_code==self.kind) || (self.kind=='expand' && new_plan_code=='start') || (self.kind=='magnify' && %w(start expand).include?(new_plan_code))
    if self.kind=='custom'
      nil
    else
      self.class.static_monthly_fee(new_plan_code)*12 - annual_credit
    end
  end

end