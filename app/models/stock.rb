class Stock < ApplicationRecord
    has_many :stocks_purchased_per_people
    has_many :stocks_sold_per_people
    validates    :name,  presence:   true, uniqueness:  {case_sensitive:  false}
    validates    :ticker,  presence:   true, uniqueness:  {case_sensitive:  false}

    def self.get(ticker)
      Finnhub::GetQuoteService.call(ticker.upcase(), false)
      Stock.find_by(ticker: ticker)
    end

    def self.get_stocks_owned(ticker, user_id)
      Stock.joins(:stocks_purchased_per_people).where(' "user_id" = ? and "ticker" = ?', user_id, ticker ).pluck(:quantity).sum() - Stock.joins(:stocks_sold_per_people).where(' "user_id" = ? and "ticker" = ?', user_id, ticker ).pluck(:quantity).sum()
    end

    def self.get_last_update(ticker)
      stock = Stock.select('updated_at').find_by(ticker: ticker)
      if stock
        return stock[:updated_at]
      end
      nil
    end

    def self.get_most_recent_price(ticker)
      Stock.find_by(ticker: ticker)[:most_recent_price]
    end

    def self.get_most_recent_quote(ticker)
      stock = Stock.find_by(ticker: ticker)
      {MOST_RECENT_PRICE => stock[:most_recent_price], DAY_CHANGE => stock[:day_change],
        DAY_PERCENT_CHANGE => stock[:day_percent_change], DAY_HIGH_PRICE => stock[:day_high_price],
        DAY_LOW_PRICE => stock[:day_low_price], DAY_OPEN_PRICE => stock[:day_open_price],
        DAY_PREVIOUS_CLOSE_PRICE => stock[:day_previous_close_price]}
    end

    def self.update_price(ticker, new_price)
      Stock.find_by(ticker: ticker).update(most_recent_price: new_price)
    end

    def self.update_quote(ticker, new_quote)
      Stock.find_by(ticker: ticker).update(most_recent_price: new_quote[MOST_RECENT_PRICE],
        day_change: new_quote[DAY_CHANGE], day_percent_change: new_quote[DAY_PERCENT_CHANGE],
        day_high_price: new_quote[DAY_HIGH_PRICE], day_low_price: new_quote[DAY_LOW_PRICE],
        day_open_price: new_quote[DAY_OPEN_PRICE], day_previous_close_price: new_quote[DAY_PREVIOUS_CLOSE_PRICE])
    end

end
