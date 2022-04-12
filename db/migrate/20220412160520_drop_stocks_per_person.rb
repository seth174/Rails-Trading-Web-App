class DropStocksPerPerson < ActiveRecord::Migration[7.0]
  def change
    drop_table :stocks_purchased_per_people
  end
end
