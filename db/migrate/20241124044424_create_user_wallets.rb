class CreateUserWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :user_wallets do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :balance

      t.timestamps
    end
  end
end
