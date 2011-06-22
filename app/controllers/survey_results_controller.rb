class SurveyResultsController < ApplicationController
  skip_filter :authenticate_user!, :only => [ :charts, :verbatims ]
  before_filter :find_survey
  
  def all
    #@survey = Survey.first(:conditions => {:code => params[:survey]})
    result_obj = @survey.result_obj
    verb_obj = @survey.verbatims_obj(params[:search], params[:name], params[:subset])
    formatted_response = {:config => @survey.result_obj[:bars], :pieConfig => @survey.result_obj[:pie], :verbatim => verb_obj  }
    
    respond_to do |format|
      format.json { render :json => @survey.result_obj }
    end
		
  end
  
  def charts
    #@survey = Survey.first(:conditions => {:code => params[:survey]})
    
    respond_to do |format|
      format.json { render :json => @survey.result_obj }
    end
		
  end
  
  def verbatims
    #@survey = Survey.first(:conditions => {:code => params[:survey]})

    respond_to do |format|
      format.json { render :json => @survey.verbatims_obj(params[:filter], params[:name], params[:subset]) }
    end
  end
  
  def delete_response
    # /account/surveys/:survey_id/survey_results/delete_response
    begin
      @result = @survey.survey_results.find(:first, :conditions => { :survey_result_id => params[:id] })
      @result.is_removed = true
      @result.save
      respond_to do |format|
        format.xml { render :xml => '<?xml version="1.0" encoding="UTF-8"?><result success="true" />' }
        format.json { render :json => { :success => true } }
      end
      
    rescue Exception => e
      respond_to do |format|
        format.xml { render :xml => '<?xml version="1.0" encoding="UTF-8"?><result success="false" />' }
        format.json { render :json => { :success => false } }
      end
    end
  end
  protected
    def find_survey
      if !params[:survey_id].blank? && !current_user.nil?
        @survey = current_user.surveys.find_by_id(params[:survey_id])
      else
        @survey = Survey.find_by_code(params[:survey])
      end
    end
end
