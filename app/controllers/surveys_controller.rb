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
        flash[:notice] = 'Emote published'
    else
        render :action => 'new'
    end
  end
  
  def destroy
    #TODO What if .delete will fail? done?
    begin
      current_user.surveys.find(params[:id]).delete
      flash[:notice] = 'Emote deleted'
    rescue
      flash[:error] = 'Emote was not deleted'
    end
    redirect_to :action => 'index'
  end
  
  def scorecard
    @survey = Survey.find_by_code(params[:code])
  end
  
  def public_scorecard
    @survey = Survey.find_by_code(params[:code])
    redirect_to(root_path) if @survey.nil? || !@survey.public?
  end

end