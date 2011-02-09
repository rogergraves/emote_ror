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
     @note = Note.new
  end

  def update
    if params[:account][:password].blank?
      params[:account].delete(:password)
      params[:account].delete(:password_confirmation)
    end
    @user = User.find(params[:id])
    if @user.update_attributes params[:user]
      flash[:notice] = "User #{@user.email} successfully saved"
      redirect_to admin_accounts_path
    else
      flash[:alert] = 'Error saving user'
      render :edit
    end
  end
  
  def add_note
    @user = User.find(params[:id])
    @note = Note.new params[:note]
    @note.creator = current_admin
    @note.subject = @user
    if @note.save
      flash[:notice] = 'Note added'
      @note = Note.new
      @user.reload
    else
      flash[:alert] = 'Error adding note'
    end
    render :edit
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "User #{@user.email} successfully deleted"
      redirect_to admin_accounts_path
    else
      flash[:alert] = 'Error deleting user'
      render :edit
    end
  end

end
