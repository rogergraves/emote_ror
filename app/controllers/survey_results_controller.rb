class SurveyResultsController < ApplicationController
  before_filter :authenticate_user!, :except => [ :charts, :verbatims ]
  # before_filter :find_survey
  
  def all
    @survey = Survey.first(:conditions => {:code => params[:survey]})
    result_obj = @survey.result_obj
    verb_obj = @survey.verbatims_obj(params[:search])
    formatted_response = {:config => @survey.result_obj[:bars], :pieConfig => @survey.result_obj[:pie], :verbatim => verb_obj  }
    
    respond_to do |format|
      format.json { render :json => @survey.result_obj }
    end
		
  end
  
  def charts
    @survey = Survey.first(:conditions => {:code => params[:survey]})
    
    respond_to do |format|
      format.json { render :json => @survey.result_obj }
    end
		
  end
  
  def verbatims
    @survey = Survey.first(:conditions => {:code => params[:survey]})

    respond_to do |format|
      format.json { render :json => @survey.verbatims_obj(params[:filter]) }
    end
  end
  
  def delete_response
    # /account/surveys/:survey_id/survey_results/delete_response
    begin
      @result = @survey.survey_results.find(:first, :conditions => { :survey_result_id => params[:id] })
      @result.is_removed = true
      @result.save
      render :xml => '<?xml version="1.0" encoding="UTF-8"?><result success="true" />'
    rescue Exception => e
      render :xml => '<?xml version="1.0" encoding="UTF-8"?><result success="false" />'
    end
  end
  protected
    def find_survey
      @survey = current_user.surveys.find_by_id(params[:survey_id]) rescue current_user.surveys.find_by_code(params[:survey_id])
    end
end
