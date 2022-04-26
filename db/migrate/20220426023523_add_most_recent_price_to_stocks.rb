class AddMostRecentPriceToStocks < ActiveRecord::Migration[7.0]
  def change
    add_column :stocks, :most_recent_price, :float
  end
end
