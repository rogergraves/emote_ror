class SurveyUserData < ActiveRecord::Base
  attr_accessible :email, :name, :phone, :survey_result_id
end
