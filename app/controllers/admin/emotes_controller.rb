class Admin::EmotesController < Admin::BaseController
  
  def index
    @emotes = Survey.paginate(:page => params[:page], :conditions => ["`users`.`email` LIKE ? or `surveys`.`code` LIKE ? or `surveys`.`project_name` LIKE ?", "%#{params[:filter]}%","%#{params[:filter]}%","%#{params[:filter]}%"], :include => [:user])
  end
  
end
