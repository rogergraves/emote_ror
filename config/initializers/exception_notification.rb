unless Rails.env.development?
  EmoteRor::Application.config.middleware.use ExceptionNotifier,
            :email_prefix => "[eMote #{Rails.env}] ",
            :sender_address => %{"notifier" <error@emotethis.com>},
            :exception_recipients => %w{roger@rubyriders.com elena.newton@rubyriders.com}
end
