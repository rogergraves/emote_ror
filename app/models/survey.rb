class Survey < ActiveRecord::Base
  belongs_to :user
  
  validates :user, :presence => true
  validates :project_name, :presence => true

  before_save(:on => :create) do
    user(true).can_add_emote?
  end

end
