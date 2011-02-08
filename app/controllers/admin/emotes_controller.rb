class Admin::EmotesController < Admin::BaseController
  before_filter :load_users, :only => [:new, :create, :edit, :update]
  def index
    @emotes = Survey.paginate(:page => params[:page], :conditions => ["`users`.`email` LIKE ? or `surveys`.`code` LIKE ? or `surveys`.`project_name` LIKE ?", "%#{params[:filter]}%","%#{params[:filter]}%","%#{params[:filter]}%"], :include => [:user])
  end
  
  def new
    @emote = Survey.new
  end
  
  def create
    @emote = Survey.new params[:emote]
    @emote.force_creation = true
    if @emote.save
      redirect_to admin_emotes_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @emote = Survey.find params[:id]
  end
  
  def update
    @emote = Survey.find params[:id]
    if @emote.update_attributes params[:emote]
      redirect_to admin_emotes_path
    else
      render :action => 'edit'
    end
  end
  
  protected
    def load_users
      @users = User.all
    end
end
