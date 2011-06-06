require 'digest/md5'

class SurveysController < ApplicationController
  before_filter :authenticate_user!, :except => [:public_scorecard]

  def index
    @surveys = current_user.surveys.all
  end
  
  def new
    @survey = Survey.new
  end

  def recreate
    begin
      current_user.surveys.find(params[:id]).destroy
      redirect_to :action => :new
    rescue
      flash[:error] = 'Error deleting e.mote&trade;'
      redirect_to :action => :index
    end
  end
  
  def create
    @survey = Survey.new params[:survey] 
    @survey.user = current_user
    @survey.state = Survey::STATE_ACTIVE
    @survey.project_name.gsub!(/(\.|\n|\s)*$/,'').gsub!(/^(\s)/,'')
    if @survey.save
        flash[:notice] = 'e.mote&trade; was published'
    else
        render :action => 'new'
    end
  end
  
  def update
    begin
      survey = current_user.surveys.find(params[:id])
      survey.state = (params["survey_#{params[:id]}_archive"]=='true' ? Survey::STATE_ARCHIVED : Survey::STATE_ACTIVE) if params[:property] == 'archive'
      survey.public = params["survey_#{params[:id]}_public"] if params[:property] == 'public'
      survey.save
    rescue
      #fuck them, they can't change anything else!
    end
    redirect_to :action => 'index'
  end
  
  def destroy
    #TODO What if .delete will fail? done? sure, sweety, thanx! :P
    begin
      current_user.surveys.find(params[:id]).destroy
      flash[:notice] = 'e.mote&trade; was deleted'
    rescue
      flash[:error] = 'Error deleting e.mote&trade;'
    end
    redirect_to :action => 'index'
  end

  def wipe_responses
    survey = current_user.surveys.find(params[:id])
    if survey.survey_results.update_all :is_removed => 1
      flash[:notice] = 'e.mote&trade; responses has been deleted'
    else
      flash[:error] = 'Error deleting e.mote&trade; responses'
    end
    redirect_to :action => 'index'
  end
  
  def scorecard
    @survey = current_user.surveys.find(params[:id])
    redirect_to root_path if @survey.nil?
    @survey.generate_action_token!
    @survey.scorecard_viewed_at = DateTime.now
    @survey.save!
  end
  
  def public_scorecard
    @survey = Survey.find_by_scorecard_code(params[:code])
    redirect_to(root_path) if @survey.nil? #|| !@survey.public?
  end
  
  def get_qrcode
    begin
      send_file Survey.qrcode_file_path(params[:id]), :type => 'image/png', :disposition => 'attachment'
    rescue ActionController::MissingFile
      render :status => 404, :text => 'Not found'
    end
  end
  
  def settings
    @survey = Survey.find(params[:id])
    if request.post?
      @survey.update_attribute(:store_respondent_contacts, params[:respondent_email]=='true')
      current_user.update_attribute(:activity_report_interval, params[:activity_interval])
      render :status => 200, :text => 'ok'
    else
      resp = {
        :activity_report_interval => current_user.activity_report_interval,
        :store_respondent_contacts => (@survey.store_respondent_contacts || false).to_s
      }
      render :json => resp
    end
  end

end