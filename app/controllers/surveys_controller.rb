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
    @survey.save!
  end
  
  def public_scorecard
    @survey = Survey.find_by_scorecard_code(params[:code])
    redirect_to(root_path) if @survey.nil? #|| !@survey.public?
  end
  
  private
    def generate_action_token
      
    end

end