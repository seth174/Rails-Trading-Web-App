module Finnhub
  class GetQuoteService < ApplicationService

    def initialize(ticker)
      @ticker = ticker.upcase()
    end

    def call
      if Stock.get_last_update(@ticker) < Time.zone.now.ago(1000)
        new_price = FinnhubApi.get_instance().quote(@ticker).to_hash()[:c]
        Stock.update_price(@ticker, new_price)
        return new_price
      end
      Stock.get_most_recent_price(@ticker)
    end


  end
end
