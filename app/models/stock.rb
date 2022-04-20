class Stock < ApplicationRecord
    has_many :stocks_purchased_per_people
    has_many :stocks_sold_per_people
    validates    :name,  presence:   true, uniqueness:  {case_sensitive:  false}
    validates    :ticker,  presence:   true, uniqueness:  {case_sensitive:  false}

    def self.find(ticker)
      Stock.find_by(ticker: ticker)
    end

    def self.get_stocks_owned(ticker, user_id)
      Stock.joins(:stocks_purchased_per_people).where('"stocks"."ticker" = "?" and "user_id" = "?"', ticker, user_id ).pluck(:quantity).sum()
    end

    def self.get_price(ticker)
      get_quote(ticker)[:c]
    end

    def self.get_quote(ticker)
      ApplicationController.helpers.get_quote(ticker)
    end

end
