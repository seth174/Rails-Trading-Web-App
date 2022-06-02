module Finnhub
  class FinnhubApi
    require 'finnhub_ruby'
    private_class_method :new

    @finnhub_client = new()

    def new
      @finnhub_client
    end

    def self.get_instance()
      FinnhubRuby.configure do |config|
        config.api_key['api_key'] = Rails.application.credentials[Rails.env.to_sym][:finnhub][:api_key]
      end
      @finnhub_client = FinnhubRuby::DefaultApi.new
    end
  end
end
