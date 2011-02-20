# == Schema Information
# Schema version: 20110220073519
#
# Table name: notes
#
#  id           :integer(4)      not null, primary key
#  creator_id   :integer(4)      not null
#  subject_id   :integer(4)
#  creator_type :string(30)      not null
#  subject_type :string(30)
#  text         :text
#  archived     :boolean(1)      default(FALSE)
#  created_at   :datetime
#  updated_at   :datetime
#

class Note < ActiveRecord::Base
  belongs_to :subject, :polymorphic => true
  belongs_to :creator, :polymorphic => true

  validates :text, :presence => true #, :length => { :minimum => 5 }
end
