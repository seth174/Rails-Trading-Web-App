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
end
