class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :type
      t.decimal :amount
      t.integer :source_wallet_id
      t.integer :target_wallet_id

      t.timestamps
    end
  end
end
