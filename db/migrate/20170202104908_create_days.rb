class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :balance
      t.integer :referral

      t.timestamps null: false
    end
  end
end
