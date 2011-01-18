class SubscriptionsController < ApplicationController
  include ActionView::Helpers::TextHelper
  before_filter :authenticate_user!
  
  def index
    
  end
  
  def create
    # (number of emotes for 1 year)
    params[:emotes]
    price = 900 * params[:emotes].to_i
    response = EXPRESS_GATEWAY.setup_purchase(
        price,
        :ip                => request.remote_ip,
        :return_url        => paypal_success_account_subscriptions_url(:only_path => false),
        :cancel_return_url => paypal_cancel_account_subscriptions_url(:only_path => false),
        :subtotal => price, :allow_guest_checkout => true, :no_shipping => 1, :description => "#{pluralize(params[:emotes], 'E.mote')} Subscription for #{price/100}$"
      )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end
  
  def paypal_success
    details = EXPRESS_GATEWAY.details_for(params[:token]) unless params[:token].blank?
    #purchase = EXPRESS_GATEWAY.purchase(
    #    (details.params['order_total']*100).to_i,
    #    :ip       => request.remote_ip,
    #    :payer_id => params[:PayerID],
    #    :token    => params[:token]
    #)

    if details.success?
    #if purchase.success?
      subscription = Subscription.new
      subscription.emote_amount = 10 # take from session
      transaction = PaypalTransaction.new
      transaction.user = current_user
      transaction.subscription = subscription
      transaction.token = details.token
      transaction.date = Time.now
      transaction.total = details.params['order_total']
      transaction.customer_name = [details.params['first_name'], details.params['middle_name'], details.params['last_name']].compact.join(' ')
      transaction.customer_id = details.payer_id
      transaction.customer_address = [details.params['street1'], details.params['city_name'], details.params['postal_code'], details.params['payer_country']].compact.join(', ')
      transaction.customer_email = details.email
      transaction.customer_phone = details.params['phone']
      transaction.description = details.params['order_description']
      subscription.save # do we need to save it?
      transaction.save
      flash[:notice] = "Thank you!"
    end
    redirect_to account_surveys_path
  end
  
  def paypal_cancel
    flash[:notice] = "You haven't completed the payment."
    redirect_to account_surveys_path
  end
    
end
