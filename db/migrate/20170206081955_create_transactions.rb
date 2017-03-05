class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.string :address
      t.integer :to_id
      t.string :to_email
      t.integer :twd_amount
      t.float :btc_amount
      t.timestamp :btc_amount_expired
      t.boolean :complete
      t.boolean :pending
      t.float :btc_recieved

      t.timestamps null: false
    end
  end
end
