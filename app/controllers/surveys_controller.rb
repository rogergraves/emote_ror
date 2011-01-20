class SurveysController < ApplicationController
  before_filter :authenticate_user!, :except => [:public_scorecard]
  before_filter :find_scorecard_by_token_or_bounce, :only => [:public_scorecard]
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
    #TODO What if .delete will fail?
    current_user.surveys.find(params[:id]).delete
    flash[:notice] = 'Emote deleted'
    redirect_to :action => 'index'
  end
  
  def scorecard
    
  end
  
  def public_scorecard
    
  end

  private
    def find_scorecard_by_token_or_bounce
      
    end
end