class User < ApplicationRecord
  has_many :deposits
  has_many :withdraws
  has_many :stocks_purchased_per_people
  has_many :stocks_sold_per_people
  has_many :balances

  validates    :name,  presence:   true,   length: {maximum:  50}
  VALIDE_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates    :email,  presence:   true,   length: {maximum:  150}, format:  {with:   VALIDE_EMAIL_REGEX},  uniqueness:  {case_sensitive:  false}
  has_secure_password()
  validates   :password, length:  {minimum:  8}

  def self.get_balance(user_id)
    Deposit.where("user_id = ?", user_id).sum('amount') + Withdraw.where("user_id = ?", user_id).sum('amount') - StocksPurchasedPerPerson.get_balance(user_id) +  StocksPurchasedPerPerson.get_positions_value(user_id) + StocksSoldPerPerson.get_sold_balance(user_id)
  end

  def self.get_cash_available(user_id)
    Deposit.where("user_id = ?", user_id).sum('amount') + Withdraw.where("user_id = ?", user_id).sum('amount') - StocksPurchasedPerPerson.get_balance(user_id) + StocksSoldPerPerson.get_sold_balance(user_id)
  end

  def self.getTransactions(user_id)
    deposit_query = Deposit.where('user_id = ?', user_id)
    withdraw_query = Withdraw.where('user_id = ?', user_id)


    sql = "#{deposit_query.to_sql} UNION #{withdraw_query.to_sql} ORDER BY created_at DESC"
    ActiveRecord::Base.connection.execute(sql)
    # User.left_outer_joins(:deposits, :withdraws).where('deposits.user_id = ?', user_id).select('deposits.amount as da', 'withdraws.amount as wa')
  end

  def self.get_stock_overview_information(user_id)

  end
end
