class SurveysController < ApplicationController
  before_filter :authenticate_user!, :except => [:public_scorecard]
  before_filter :find_scorecard_by_token_or_bounce, :only => [:public_scorecard]
  def index
    
  end
  
  def new
    
  end
  
  def create
    
  end
  
  def scorecard
    
  end
  
  def public_scorecard
    
  end
  
  private
    def find_scorecard_by_token_or_bounce
      
    end
end