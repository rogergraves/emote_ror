class Survey < ActiveRecord::Base
  require 'zlib'

  belongs_to :user
  
  validates :user, :presence => true
  validates :project_name, :presence => true
  validates :code, :presence => true, :uniqueness => true
  
  before_validation(:on => :create) do
    generate_survey_code!
  end

  before_save(:on => :create) do
    unless user(true).can_add_emote?
      errors[:user] = ' cannot add more emotes'
      return false
    end
  end

  def generate_survey_code!
    self.code = Zlib::crc32("#{self.user ? self.user.first_name : 'no_user'}-#{self.user_id}--#{self.id}-#{self.project_name}-[OMATORE]").to_s(36).upcase
  end

end
