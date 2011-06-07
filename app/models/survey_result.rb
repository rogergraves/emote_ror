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

class SurveyResult < ActiveRecord::Base
  set_table_name  'survey_result'
  set_primary_key 'survey_result_id'
  
  EMOTIONS = {
    'enthusiastic' => :positive,
		'elated' => :positive,
		'excited' => :positive,
		'thrilled' => :positive,
		'amazed' => :positive,
		'happy' => :positive,
		'satisfied' => :positive,
		'surprised' => :positive,
		'content' => :positive,
		'delighted' => :positive,
		'outraged' => :negative,
		'angry' => :negative,
		'unhappy' => :negative,
		'frustrated' => :negative,
		'irritated' => :negative,
		'humiliated' => :negative,
		'disgusted' => :negative,
		'miserable' => :negative,
		'dissatisfied' => :negative,
		'uneasy' => :negative
  }
  
  def self.positives
    EMOTIONS.select {|k,v| v == :positive }.map {|k,v| k}
  end
  
  def self.negatives
    EMOTIONS.select {|k,v| v == :negative }.map {|k,v| k}
  end
  
  
  belongs_to :survey, :foreign_key => :code
  
  def id
    read_attribute(:survey_result_id)
  end
  
  def id=(id)
    write_attribute(:survey_result_id, id)
  end
  
end
