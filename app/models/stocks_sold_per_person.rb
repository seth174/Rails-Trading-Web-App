class StocksSoldPerPerson < ApplicationRecord
  belongs_to :stock
  belongs_to :user

  def self.find_by_user_id(user_id)
    StocksSoldPerPerson.where('user_id = ?', user_id)
  end

  def self.get_stocks_sold(user_id)
    sql =
    "SELECT c.user_id, c.name, c.ticker, c.selling_price as price, c.quantity
    FROM users u
    INNER JOIN (
      select sp.selling_price, s2.name, s2.ticker, sp.user_id, sp.quantity
      From stocks_sold_per_people sp
      INNER JOIN stocks s2 on s2.id = sp.stock_id
      where sp.user_id = #{user_id}
    ) as c on c.user_id = u.id
    where u.id = #{user_id}
    ORDER BY c.ticker" % [user_id, user_id]
    results = ActiveRecord::Base.connection.execute(sql)
  end

  def self.get_sold_balance(user_id)
    StocksSoldPerPerson.where('user_id = ?', user_id).sum('selling_price * quantity')
  end

  def self.get_sold_balance_stock(user_id, ticker)
    Stock.joins(:stocks_sold_per_people).where('user_id = ? and stocks.ticker = ?', user_id, ticker).sum('selling_price * quantity')
  end

  def self.count_stocks_sold(ticker, user_id)
    Stock.joins(:stocks_sold_per_people).where("stocks.ticker = ? and user_id = ?", ticker, user_id).pluck(:quantity).sum()
  end

end
