class StocksPurchasedPerPerson < ApplicationRecord
  belongs_to :stock
  belongs_to :user

  validates    :buying_price,  presence:   true
  validates    :stock_id,  presence:   true
  validates    :user_id,  presence:   true
  validates    :quantity,  presence:   true, :numericality => { :greater_than => 0 }

  def self.find_by_user_id(user_id)
    StocksPurchasedPerPerson.where('user_id = ?', user_id)
  end

  def self.get_balance(user_id)
    StocksPurchasedPerPerson.where('user_id = ?', user_id).sum('buying_price * quantity')
  end

  def self.get_stock_balance(user_id, ticker, quantity)
    results = Stock.joins(:stocks_purchased_per_people).where('user_id = ? and stocks.ticker = ?', user_id, ticker).order(:created_at).pluck(:buying_price, :quantity)
    sum = 0
    quantity_per_price = 0
    results.each() do |r|
      if quantity == 0
        return sum
      end
      quantity_per_price = r[1] > quantity ? quantity : r[1]
      sum += quantity_per_price * r[0]
      quantity -= quantity_per_price
    end
    sum
  end

  def self.get_positions_value(user_id)
    results = Stock.joins(:stocks_purchased_per_people).where("user_id = ?", user_id).distinct()

    sum_stocks(results, user_id)
  end

  def self.get_stock(ticker, user_id)
    StocksPurchasedPerPerson.joins(:stocks).where('"user_id" = ? and "stocks"."ticker" = ?', user_id, ticker)
  end

  def self.get_stock_count(ticker, user_id)
    get_stock(ticker, user_id).count()
  end

  def self.get_stocks_purchased(user_id)
    sql =
    "SELECT c.user_id, c.name, c.ticker, c.buying_price as price, c.quantity
    FROM users u
    INNER JOIN (
      select sp.buying_price, s2.name, s2.ticker, sp.user_id, sp.quantity
      From stocks_purchased_per_people sp
      INNER JOIN stocks s2 on s2.id = sp.stock_id
      where sp.user_id = #{user_id}
    ) as c on c.user_id = u.id
    where u.id = #{user_id}
    ORDER BY c.ticker"

    results = ActiveRecord::Base.connection.execute(sql)
  end

  def self.count_stocks_purchased(ticker, user_id)
    Stock.joins(:stocks_purchased_per_people).where("stocks.ticker = ? and user_id = ?", ticker, user_id).pluck(:quantity).sum()
  end

  private
  def self.sum_stocks(results, user_id)
    sum = 0
    results.each() do |r|
      purchased_amount = count_stocks_purchased(r["ticker"], user_id)
      sold_amount = StocksSoldPerPerson.count_stocks_sold(r["ticker"], user_id)
      if purchased_amount - sold_amount == 0
        next
      end
      price = ApplicationController.helpers.get_quote(r["ticker"])
      sum += price * (purchased_amount - sold_amount)
    end
    sum
  end

end
