class SubscriptionsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_filter :authenticate_user!
  
  
  def index
    @subscriptions = current_user.current_subscriptions
    @payments = current_user.subscriptions.all(:order => 'id DESC')
  end
  
  def new
    
  end
  
  def create
    # save settings to session
    session[:selected_subscription_code] = params[:prod_id]
    subscription_obj = Subscription::OPTIONS.select{|s| s[:prod_code] == params[:prod_id]}.first rescue Subscription::OPTIONS.last
    price = subscription_obj[:price]
    currency = Country.find_by_country_code(current_user.country_code || 'US')[:currency]
    response = EXPRESS_GATEWAY.setup_purchase(
        price * 100, # convert to cents
        :ip                => request.remote_ip,
        :return_url        => paypal_success_account_subscriptions_url(:only_path => false),
        :cancel_return_url => paypal_cancel_account_subscriptions_url(:only_path => false),
        :subtotal => price * 100, :allow_guest_checkout => true, :no_shipping => 1, :description => "#{subscription_obj[:name]} for #{Country.curr_code_to_symbol(currency)}#{price} ",
        :currency => currency
      )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end
  
  def paypal_success
    subscription_obj = Subscription::OPTIONS.select{|s| s[:prod_code] == session[:selected_subscription_code]}.first rescue Subscription::OPTIONS.last
    details = EXPRESS_GATEWAY.details_for(params[:token]) unless params[:token].blank?
    purchase = EXPRESS_GATEWAY.purchase(
        (subscription_obj[:price]*100).to_i,
        :ip       => request.remote_ip,
        :payer_id => params[:PayerID],
        :token    => params[:token],
        :currency => details.params['order_total_currency_id']
    )
    #if details.success?
    if purchase.success?
      subscription = Subscription.new(:start_date => DateTime.now, :user_id => current_user.id)
      subscription.emote_amount = subscription_obj[:amount] if (details.params['order_total'].to_f == subscription_obj[:price].to_f)
      subscription.trial = false #Auto sets duration
      transaction = PaypalTransaction.new
      transaction.user = current_user
      transaction.subscription = subscription
      transaction.token = details.token
      transaction.date = Time.now
      transaction.currency = details.params['order_total_currency_id']
      transaction.total = details.params['order_total']
      transaction.customer_name = [details.params['first_name'], details.params['middle_name'], details.params['last_name']].compact.join(' ')
      transaction.customer_id = details.payer_id
      transaction.customer_address = [details.params['street1'], details.params['city_name'], details.params['postal_code'], details.params['payer_country']].compact.join(', ')
      transaction.customer_email = details.email
      transaction.customer_phone = details.params['phone']
      transaction.description = subscription_obj[:name]
      transaction.product_code = subscription_obj[:prod_code]
      subscription.save # do we need to save it? -=- It should be saved by transaction.save but we need to be 100% sure
      transaction.save
      flash[:notice] = "Thank you!"
    end
    redirect_to account_subscriptions_path
  end
  
  def paypal_cancel
    flash[:notice] = "You haven't completed the payment."
    redirect_to account_subscriptions_path
  end
    
end
