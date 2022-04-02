module StocksHelper
  require 'finnhub_ruby'
  def finnhub_client
    unless @finnhub_client
      FinnhubRuby.configure do |config|
        config.api_key['api_key'] = 'c78g7iqad3icbce84at0'
      end
      @finnhub_client = FinnhubRuby::DefaultApi.new
    end
    @finnhub_client
end
end
