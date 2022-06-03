class AddColumnsToStock < ActiveRecord::Migration[7.0]
  def change
    add_column :stocks, :day_change, :float
    add_column :stocks, :day_percent_change, :float
    add_column :stocks, :day_high_price, :float
    add_column :stocks, :day_low_price, :float
    add_column :stocks, :day_open_price, :float
    add_column :stocks, :day_previous_close_price, :float
  end
end
