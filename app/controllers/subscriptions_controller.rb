class SubscriptionsController < ApplicationController
  include ActionView::Helpers::TextHelper
  
  def index
    @payments = current_user.payments.all(:order => 'created_at DESC')
  end
  
  def create
    unless current_user.plan.can_upgrade_to?(params[:target_plan])
      flash[:alert] = "You cannot upgrade to the specified plan"
      render :new
      return
    end
    
    plan_hash = Subscription.get_plan_hash(params[:target_plan], true)
    price = current_user.plan.calc_upgrade_price(params[:target_plan])
    currency = Country.find_by_country_code(current_user.country_code || 'US')[:currency]
    selected_purchase = {
      :plan_code => params[:target_plan],
      :description => "Upgrade account from '#{current_user.plan.human_name}' to '#{plan_hash[:name]}' for #{Country.curr_code_to_symbol(currency)}#{price}"
    }
    response = EXPRESS_GATEWAY.setup_purchase(
        price * 100, # convert to cents
        :ip                => request.remote_ip,
        :return_url        => paypal_success_account_subscriptions_url(:only_path => false),
        :cancel_return_url => paypal_cancel_account_subscriptions_url(:only_path => false),
        :subtotal => price * 100, :allow_guest_checkout => true, :no_shipping => 1, :description => selected_purchase[:description],
        :currency => currency
      )
    # save settings to session
    session[:selected_plan_purchase] = selected_purchase
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end
  
  def paypal_success
    selected_purchase = session[:selected_plan_purchase]
    plan_hash = Subscription.get_plan_hash(selected_purchase[:plan_code], true)
    details = EXPRESS_GATEWAY.details_for(params[:token]) unless params[:token].blank?
=begin
    purchase = EXPRESS_GATEWAY.purchase(
        (subscription_obj[:price]*100).to_i,
        :ip       => request.remote_ip,
        :payer_id => params[:PayerID],
        :token    => params[:token],
        :currency => details.params['order_total_currency_id']
    )

    if purchase.success?
=end    
    if details.success?
      payment = Payment.new(:user_id => current_user.id, :source => 'paypal')
      payment.token = details.token
      payment.purchase_date = Time.now
      payment.total_paid = details.params['order_total'].to_f
      payment.customer_name = [details.params['first_name'], details.params['middle_name'], details.params['last_name']].compact.join(' ')
      payment.customer_id = details.payer_id
      payment.customer_address = [details.params['street1'], details.params['city_name'], details.params['postal_code'], details.params['payer_country']].compact.join(', ')
      payment.customer_email = details.email
      payment.customer_phone = details.params['phone']
      payment.description = selected_purchase[:description]
      payment.currency = details.params['order_total_currency_id']
      payment.save
      expected_price = current_user.plan.calc_upgrade_price(selected_purchase[:plan_code])
      current_user.plan.upgrade!(plan_hash[:kind]) if (details.params['order_total'].to_f == expected_price.to_f)
      flash[:notice] = "Thank you for subscribing! Your PayPal Transaction ID is ##{payment.token}."
      session[:selected_plan_purchase] = nil
    end
    redirect_to account_subscriptions_path
  end
  
  def paypal_cancel
    flash[:notice] = "You haven't completed the payment."
    redirect_to account_subscriptions_path
  end
    

end
