module Finnhub
  class GetStockCandlesService < ApplicationService

    def initialize(ticker, interval, start_day, today)
      @ticker = ticker.upcase()
      @interval = interval
      @start_day = start_day
      @today = today
    end

    def call
      FinnhubApi.get_instance().stock_candles(@ticker, @interval, @start_day, @today).to_hash
    end


  end
end
