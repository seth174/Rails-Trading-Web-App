class StocksSoldPerPerson < ApplicationRecord
  belongs_to :stock
  belongs_to :user

  def self.find_by_user_id(user_id)
    StocksSoldPerPerson.where('user_id = ?', user_id)
  end

end
