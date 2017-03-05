class AddStatusToTransaction < ActiveRecord::Migration
  def change
  	remove_column :transactions, :complete
  	remove_column :transactions, :pending
  	add_column :transactions, :status, :string, default: 'waiting'
  end
end
