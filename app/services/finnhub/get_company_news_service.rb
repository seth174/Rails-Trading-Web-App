module Finnhub
  class GetCompanyNewsService < ApplicationService
    def initialize(ticker)
      @ticker = ticker
    end

    def call
      date = Date.today()

      FinnhubApi.get_instance().company_news(@ticker, date.years_ago(1), date)
    end
  end
end
