#ActiveMerchant::Billing::Base.mode = :test
ActiveMerchant::Billing::Base.mode = :production
paypal_options = {
   :login => "azwerner_api1.hotmail.com",
   :password => "ASGQTMMD8NV9T3BU",
   :signature => "AzCuznm5EkUH9j7jPjOi1VJziXaiARcRbsfWdGZLy0dBhOQFEjLGLyHA"
}
::EXPRESS_GATEWAY = ActiveMerchant::Billing::PaypalExpressGateway.new(paypal_options)
