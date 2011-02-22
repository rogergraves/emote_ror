# == Schema Information
# Schema version: 20110220073519
#
# Table name: survey_result
#
#  survey_result_id :integer(8)      not null, primary key
#  start_time       :datetime
#  end_time         :datetime
#  ip               :string(50)
#  emote            :string(255)
#  intensity_level  :integer(4)
#  verbatim         :text(16777215)
#  code             :string(255)
#  is_removed       :integer(1)      default(0)
#

class SurveyResponse
  include Mongoid::Document
  
  field :start_time, :type => DateTime
  field :end_time, :type => DateTime
  field :ip, :type => String
  field :emote, :type => String
  field :intensity_level, :type => Integer
  field :verbatim, :type => String
  field :removed, :type => Boolean, :default => false

  referenced_in :survey
    
  #belongs_to :survey, :foreign_key => :code
  
end
