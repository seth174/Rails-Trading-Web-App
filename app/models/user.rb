class User < ApplicationRecord
  has_many :deposits
  has_many :withdraws

  validates    :name,  presence:   true,   length: {maximum:  50}
  VALIDE_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates    :email,  presence:   true,   length: {maximum:  150}, format:  {with:   VALIDE_EMAIL_REGEX},  uniqueness:  {case_sensitive:  false}
  has_secure_password()
  validates   :password, length:  {minimum:  8}

  def self.getBalance(user_id)
    Deposit.where("user_id = ?", user_id).sum('amount') + Withdraw.where("user_id = ?", user_id).sum('amount')
  end

  def self.getTransactions(user_id)
    deposit_query = Deposit.where('user_id = ?', user_id)
    withdraw_query = Withdraw.where('user_id = ?', user_id)


    sql = "#{deposit_query.to_sql} UNION #{withdraw_query.to_sql} ORDER BY created_at DESC"
    ActiveRecord::Base.connection.execute(sql)
    # User.left_outer_joins(:deposits, :withdraws).where('deposits.user_id = ?', user_id).select('deposits.amount as da', 'withdraws.amount as wa')
  end
end
