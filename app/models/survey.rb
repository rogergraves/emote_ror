# == Schema Information
# Schema version: 20110118230554
#
# Table name: surveys
#
#  id              :integer(4)      not null, primary key
#  user_id         :integer(4)
#  project_name    :string(255)     not null
#  score           :float           default(0.0)
#  responses_count :integer(4)      default(0)
#  active          :boolean(1)      default(FALSE)
#  public          :boolean(1)      default(FALSE)
#  created_at      :datetime
#  updated_at      :datetime
#  code            :string(20)      not null
#

class Survey < ActiveRecord::Base
  require 'zlib'

  belongs_to :user
  
  validates :user, :presence => true
  validates :project_name, :presence => true
  validates :code, :presence => true, :uniqueness => true

  attr_accessible :project_name, :public, :active
  
  before_validation(:on => :create) do
    generate_survey_code!
  end

  validate(:on => :create) do |survey|
    unless survey.user(true).can_add_scorecard?
      survey.errors[:user] = ' cannot add more emotes'
    end
  end

  def emote_direct_link
    "http://www.emotethis.com/index.php?uid=#{self.code}"
  end

  def emote_embed_link
    "<iframe src='#{emote_direct_link}'/>" #Approx.
  end

protected

  def generate_survey_code!
    self.code = Zlib::crc32("#{self.user ? self.user.full_name : 'no_user'}-#{self.user_id}--#{self.id}-#{self.project_name}-=-[OMATORE]-=-#{Time.now.to_i}").to_s(36).upcase
  end

end
