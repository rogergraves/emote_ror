class SurveyResultsController < ApplicationController
  before_filter :authenticate_user!, :except => [ :charts, :verbatims ]
  before_filter :find_survey
  
  def charts
    
  end
  
  def verbatims
    
  end
  
  def delete_response
    # /account/surveys/:survey_id/survey_results/delete_response
    @result = @survey.survey_results.find(:first, :conditions => { :survey_result_id => params[:id] })
    respond_to do |format|
      format.xml do
        if @result.destroy
          
        else
          
        end
      end
    end
  end
  protected
    def find_survey
      @survey = current_user.surveys.find_by_id(params[:survey_id]) rescue current_user.surveys.find_by_code(params[:survey_id])
    end
end
