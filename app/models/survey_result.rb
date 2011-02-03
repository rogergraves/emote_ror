class SurveyResult < ActiveRecord::Base
  set_table_name  'survey_result'
  set_primary_key 'survey_result_id'
  
  belongs_to  :survey
  
  def id
    read_attribute(:survey_result_id)
  end
  
  def id=(id)
    write_attribute(:survey_result_id, id)
  end
end
