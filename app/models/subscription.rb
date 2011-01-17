class Subscription < ActiveRecord::Base
  belongs_to :user

  validates :user, :presence => true
  validates :created_at, :presence => true
  validates :emote_amount, :presence => true, :numericality => true, :inclusion => {:in => [1, 5, 10, 25]}

  alias_attribute :starts, :created_at
  def ends
    1.year.since(starts)
  end

  def active?
    (starts..ends) === DataTime.now
  end

end
