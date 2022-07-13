module Finnhub
  class GetQuoteService < ApplicationService

    def initialize(ticker, new)
      @ticker = ticker.upcase()
      @new = new
    end

    def call
      if @new or (Stock.get_last_update(@ticker) < Time.zone.now.ago(1000) and ((Date.today.workday? and Time.now.during_business_hours?) or Stock.get_last_update(@ticker) < 0.business_hours.ago))
        new_quote = FinnhubApi.get_instance().quote(@ticker).to_hash()
        unless @new
          Stock.update_quote(@ticker, new_quote)
        end
        return new_quote
      end
      Stock.get_most_recent_quote(@ticker)
    end


  end
end
