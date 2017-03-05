class ChangeBelongsFromTransaction < ActiveRecord::Migration
  def change
  	remove_reference :transactions, :user, index: true, foreign_key: true

  	remove_column :transactions, :address_id
  	add_column :addresses, :address_id, :string

  	add_reference :transactions, :address, index: true, foreign_key: true
  end
end
