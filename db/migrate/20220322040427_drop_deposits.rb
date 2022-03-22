class DropDeposits < ActiveRecord::Migration[7.0]
  def change
    drop_table :deposits
  end
end
