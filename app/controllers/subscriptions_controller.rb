class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    
  end
  
  def create
    # (number of emotes for 1 year)
    session[:listing_agent_payment] = { :duration => params[:duration].to_i, :exhibitions => (params[:exhibitions]=='true'), :events => (params[:events]=='true')}
    price, description = calculate_price(params[:duration].to_i, (params[:exhibitions]=='true'), (params[:events]=='true'))
    response = EXPRESS_GATEWAY.setup_purchase(
        price,
        :ip                => request.remote_ip,
        :return_url        => paypal_success_venue_listing_agent_url(current_user, :only_path => false),
        :cancel_return_url => paypal_cancel_venue_listing_agent_url(current_user, :only_path => false),
        :subtotal => price, :allow_guest_checkout => true, :no_shipping => 1, :description => '$' + (price/100).to_s + ' ' +description
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
      if current_user.listing_agent.nil?
        current_user.listing_agent = ListingAgent.new
        current_user.listing_agent.payment_date = Time.now
        current_user.listing_agent.valid_through = session[:listing_agent_payment][:duration].months.from_now 
        current_user.listing_agent.total = details.params['order_total']
        current_user.listing_agent.exhibitions_enabled = session[:listing_agent_payment][:exhibitions]
        current_user.listing_agent.events_enabled = session[:listing_agent_payment][:events]
        current_user.listing_agent.save
        current_user.listing_agent_enabled = true
        current_user.listing_agent_end_date = current_user.listing_agent.valid_through
      end
      payment = PayPalPayment.new
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
      flash[:notice] = "Thank you! You can now use Listing Agent features."
    end
    redirect_to venue_listing_agent_path(current_user)
  end
  
  def paypal_cancel
    flash[:notice] = "You haven't completed the payment."
    redirect_to subscriptions_path
  end
    
end
