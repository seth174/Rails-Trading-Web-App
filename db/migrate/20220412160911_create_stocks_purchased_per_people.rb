class CreateStocksPurchasedPerPeople < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks_purchased_per_people do |t|
      t.float :buying_price
      t.integer :stock_id
      t.integer :user_id
      t.integer :quantity

      t.timestamps
    end
  end
end
