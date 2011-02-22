module EmoteRor
  class Application < Rails::Application
    config.mongoid.logger = Logger.new($stdout, :warn)
  end
end