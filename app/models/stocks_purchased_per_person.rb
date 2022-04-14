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

  def self.get_money_spent(user_id)
    sql = "
    SELECT s.ticker, sp.quantity
    FROM stocks_purchased_per_people sp
    INNER JOIN stocks s on s.id = sp.stock_id
    WHERE user_id = #{user_id}
    ORDER BY s.ticker
    "
    results = ActiveRecord::Base.connection.execute(sql)

    sum_stocks(results)
  end

  private
  def self.sum_stocks(results)
    sum = 0
    previous_ticker = ''
    previous_price = 0
    results.each() do |r|
      if previous_ticker != r["ticker"]
        previous_price = ApplicationController.helpers.get_quote(r["ticker"])[:c]
      end
      sum += previous_price * r["quantity"]
    end
    sum
  end

end
