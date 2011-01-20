#ActiveMerchant::Billing::Base.mode = :test
ActiveMerchant::Billing::Base.mode = :production
paypal_options = {
   :login => "e.newton_api1.inspirationengine.com",
   :password => "HWQ5MG374PBFKPLM",
   :signature => "AszaIT-3W0vM0ejHYuqsIGKXEyuIA8.l7iVdlX21OJNuu09jA34js1z3"
}

::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
