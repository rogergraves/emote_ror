class Admin::AccountsController < Admin::BaseController

  def index
    @users = User.paginate(:page => params[:page]) #, :conditions => ["`users`.`email` LIKE ? or `surveys`.`code` LIKE ? or `surveys`.`project_name` LIKE ?", "%#{params[:filter]}%","%#{params[:filter]}%","%#{params[:filter]}%"], :include => [:user])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "User #{user.email} successfullu saved"
      redirect_to admin_accounts_path
    else
      flash[:alert] = 'Error saving user'
      render :new
    end
  end

  def edit
     @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes params[:user]
      flash[:notice] = "User #{user.email} successfullu saved"
      redirect_to admin_accounts_path
    else
      flash[:alert] = 'Error saving user'
      render :new
    end
  end

end
