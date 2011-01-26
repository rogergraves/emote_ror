require 'digest/md5'

class SurveysController < ApplicationController
  before_filter :authenticate_user!, :except => [:public_scorecard]
  def index
    @surveys = current_user.surveys.all
  end
  
  def new
    @survey = Survey.new
  end
  
  def create
    @survey = Survey.new params[:survey] 
    @survey.user = current_user
    if @survey.save
        flash[:notice] = 'e.mote was published'
    else
        render :action => 'new'
    end
  end
  
  def update
    begin
      survey = current_user.surveys.find(params[:id])
      survey.active = params["survey_#{params[:id]}_active"] if params[:property] == 'active'
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
      current_user.surveys.find(params[:id]).delete
      flash[:notice] = 'e.mote was deleted'
    rescue
      flash[:error] = 'Error deleting e.mote'
    end
    redirect_to :action => 'index'
  end
  
  def scorecard
    @survey = current_user.surveys.find(params[:id])
    redirect_to root_path if @survey.nil?
    @survey.action_token = Digest::MD5.hexdigest("#{@survey.id}-==-#{@survey.code}-=-#{Time.now}")
    @survey.save!
  end
  
  def public_scorecard
    @survey = Survey.find_by_code(params[:code])
    redirect_to(root_path) if @survey.nil? || !@survey.public?
  end
  
  private
    def generate_action_token
      
    end

end