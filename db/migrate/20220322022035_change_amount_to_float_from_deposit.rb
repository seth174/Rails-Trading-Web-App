class ChangeAmountToFloatFromDeposit < ActiveRecord::Migration[7.0]
  def change
    change_table :deposits do |table|
      table.change :amount, :float
    end
  end
end
