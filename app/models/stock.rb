class Stock < ApplicationRecord
    has_many :stocks_purchased_per_people
    has_many :stocks_sold_per_people
    validates    :name,  presence:   true, uniqueness:  {case_sensitive:  false}
    validates    :ticker,  presence:   true, uniqueness:  {case_sensitive:  false}

    def self.find(ticker)
      Stock.find_by(ticker: ticker)
    end

    def self.get_stocks_owned(ticker, user_id)
      Stock.joins(:stocks_purchased_per_people).where(' "user_id" = ? and "ticker" = ?', user_id, ticker ).pluck(:quantity).sum() - Stock.joins(:stocks_sold_per_people).where(' "user_id" = ? and "ticker" = ?', user_id, ticker ).pluck(:quantity).sum()
    end

    def self.get_price(ticker)
      get_quote(ticker)
    end

    def self.get_quote(ticker)
      ApplicationController.helpers.get_quote(ticker)
    end

    def self.get_last_update(ticker)
      Stock.select('updated_at').find_by(ticker: ticker)[:updated_at]
    end

    def self.get_most_recent_price(ticker)
      Stock.find_by(ticker: ticker)[:most_recent_price]
    end

    def self.update_price(ticker, new_price)
      Stock.find_by(ticker: ticker).update(most_recent_price: new_price)
    end

end
