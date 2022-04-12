class ChangeFloatForBuyingPrice < ActiveRecord::Migration[7.0]
  def change
    def self.up
      change_table :stocks_purchased_per_people do |t|
        t.change :buying_price, :float
      end
  end
  def self.down
    change_table :stocks_purchased_per_people do |t|
      t.change :buying_price, :integer
    end
  end
end
end
