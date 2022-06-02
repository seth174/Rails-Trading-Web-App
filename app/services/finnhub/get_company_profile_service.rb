module Finnhub
  class GetCompanyProfile < ApplicationService

    def initialize(ticker)
      @ticker = ticker.upcase()
    end

    def call
      FinnhubApi.get_instance().company_profile2({symbol: @ticker}).to_hash
    end


  end
end
