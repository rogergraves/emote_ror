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
      
      transaction = PaypalTransaction.new
=begin
      payment.user_id = current_user.id
      payment.total = details.params['order_total']
      payment.customer_address = [details.params['street1'], details.params['city_name'], details.params['postal_code'], details.params['payer_country']].join(', ')
      payment.customer_email = details.email
      payment.customer_name = [details.params['first_name'], details.params['middle_name'], details.params['last_name']].join(' ')
      payment.description = details.params['order_description']
      payment.token = details.token
      payment.customer_phone = details.params['phone']
      payment.customer_hash = details
      payment.customer_id = details.payer_id
      payment.date = Time.now
      payment.payment_type = 'ListingAgent'
      payment.related_id = current_user.listing_agent.id
      payment.save
      current_user.listing_agent.transaction_id = payment.id
      current_user.listing_agent.save
=end
      flash[:notice] = "Thank you!"
    end
    redirect_to account_surveys_path
  end
  
  def paypal_cancel
    flash[:notice] = "You haven't completed the payment."
    redirect_to account_surveys_path
  end
    
end
