unless Rails.env.development?
  EmoteRor::Application.config.middleware.use ExceptionNotifier,
            :email_prefix => "[EMote] ",
            :sender_address => %{"notifier" <error@emotethis.com>},
            :exception_recipients => %w{a@rubyriders.com oleg@rubyriders.com}
end