class CreateStocksSoldPerPeople < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks_sold_per_people do |t|
      t.integer :quantity
      t.float :selling_price
      t.integer :stock_id
      t.integer :user_id

      t.timestamps
    end
  end
end
