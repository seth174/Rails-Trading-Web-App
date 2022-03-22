class DropWithdraw < ActiveRecord::Migration[7.0]
  def change
    drop_table :withdraws
  end
end
