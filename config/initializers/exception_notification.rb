#unless Rails.env.development?
#  EmoteRor::Application.config.middleware.use ExceptionNotifier,
#            :email_prefix => "[eMote #{Rails.env}] ",
#            :sender_address => %{"notifier" <error@emotethis.com>},
#            :exception_recipients => %w{a@rubyriders.com oleg+Alarm@rubyriders.com}
#end