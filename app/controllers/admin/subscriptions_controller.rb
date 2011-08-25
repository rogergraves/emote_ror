class Admin::SubscriptionsController < Admin::BaseController

  sortable_table Subscription,
    :per_page => 50,
    :default_sort => ['user.email', 'DESC'],
    :table_headings => [
      ['Customer', 'user.email'],
      ['Plan', "kind"],
      ['# of emotes', 'emote_amount'],
      ['Begins', "start_date"],
      ['Expires', "end_date"],
      ['Partner code', 'user.partner_code']
    ],
    :include_relations => [:user],
    :sort_map =>  {
      'user.email' => ['users.email'],
      'kind' => ['subscriptions.kind'],
      'emote_amount' => ['subscriptions.emote_amount'],
      'start_date' => ['subscriptions.start_date'],
      'end_date' => ['subscriptions.end_date'],
      'user.partner_code' => ['users.partner_code']
    },
    :search_array => ['users.partner_code', 'users.email']



  def index
    options = {}
    unless params[:include_trial]=='true'
      options = {:conditions => '`subscriptions`.`kind` <> "free"'}
    end
    get_sorted_objects(params, options)
  end
  
   def edit
    @subscription = Subscription.find(params[:id])
  end
  
  def update
    @subscription = Subscription.find(params[:id])
    if @subscription.update_attributes params[:subscription]
      flash[:notice] = "Subscription successfully updated"
      redirect_to admin_subscriptions_path
    else
      flash[:alert] = 'Error updating subscription'
      render :action => 'edit'
    end
  end
  
end
