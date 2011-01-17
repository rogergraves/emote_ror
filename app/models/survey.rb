class Survey < ActiveRecord::Base
  belongs_to :user
  
  validates :user, :presence => true
  validates :project_name, :presence => true

end
