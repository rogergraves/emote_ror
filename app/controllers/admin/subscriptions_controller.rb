class Admin::SubscriptionsController < Admin::BaseController

  sortable_table Subscription,
    :default_sort => ['user.email', 'DESC'],
    :table_headings => [
      ['Customer', 'user.email'],
      ['Date purchased', 'created_at'],
      ['Description', "transaction.description", nil, '1 emote'],
      ['# of emotes', 'emote_amount'],
      ['Transaction #', "transaction.token", nil, 'FREE TRIAL'],
      ['Paid', "transaction.total", :paid, '0'],
      ['Begins', "start_date"],
      ['Expires', "end_date"]
    ],
    :include_relations => [:user, :transaction],
    :sort_map =>  {
      'user.email' => ['users.email'],
      'created_at' => ['subscriptions.created_at'],
      'transaction.description' => ['paypal_transactions.description'],
      'emote_amount' => ['subscriptions.emote_amount'],
      'transaction.token' => ['paypal_transactions.token'],
      'transaction.total' => ['paypal_transactions.total'],
      'start_date' => ['subscriptions.start_date'],
      'end_date' => ['subscriptions.end_date']
    },
    :search_array => ['paypal_transactions.token']



  before_filter :load_users, :only => [:new, :create, :edit, :update]

  def index
    get_sorted_objects(params)
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
