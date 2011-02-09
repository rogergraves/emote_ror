class Note < ActiveRecord::Base
  belongs_to :subject, :polymorphic => true
  belongs_to :creator, :polymorphic => true
end
