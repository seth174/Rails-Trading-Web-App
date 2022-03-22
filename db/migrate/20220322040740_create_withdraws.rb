class CreateWithdraws < ActiveRecord::Migration[7.0]
  def change
    create_table :withdraws do |t|
      t.float :amount
      t.integer :user_id

      t.timestamps
    end
  end
end
