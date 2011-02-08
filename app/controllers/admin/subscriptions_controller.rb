class Admin::SubscriptionsController < Admin::BaseController
  before_filter :load_users, :only => [:new, :create, :edit, :update]

  def index
    conditions = (params[:exclude_trial]) ? ["(`users`.`email` LIKE ? or `paypal_transactions`.`token` LIKE ?) and `paypal_transactions`.`id` is not null", "%#{params[:filter]}%","%#{params[:filter]}%"] : ["`users`.`email` LIKE ? or `paypal_transactions`.`token` LIKE ?", "%#{params[:filter]}%","%#{params[:filter]}%"]
    @subscriptions = Subscription.paginate(:page => params[:page], :conditions => conditions, :include => [:user, :transaction])
  end
  
  def new
    @subscription = Subscription.new
    @subscription.start_date = Time.now
    @subscription.end_date = 1.year.from_now
  end
  
  def create
    @subscription = Subscription.new params[:subscription]
    @subscription.transaction = PaypalTransaction.new
    @subscription.transaction.user_id = @subscription.user_id
    @subscription.transaction.total = 0
    @subscription.transaction.token = 'ADMIN CREATED'
    if @subscription.save
      redirect_to admin_subscriptions_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @subscription = Subscription.find params[:id]
  end
  
  def update
    @subscription = Subscription.find params[:id]
    if @subscription.update_attributes params[:subscription]
      redirect_to admin_subscriptions_path
    else
      render :action => 'edit'
    end
  end
  
  protected
    def load_users
      @users = User.all
    end  
end
