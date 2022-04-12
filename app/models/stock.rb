class Stock < ApplicationRecord
    has_many :stocks_purchased_per_people
    validates    :name,  presence:   true, uniqueness:  {case_sensitive:  false}
    validates    :ticker,  presence:   true, uniqueness:  {case_sensitive:  false}

    def self.find(ticker)
      Stock.find_by(ticker: ticker)
    end

end
