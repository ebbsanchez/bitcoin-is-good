class RemoveToWhomFromTransactions < ActiveRecord::Migration
  def change
  	remove_column :transactions, :to_id
  	remove_column :transactions, :to_email
  end
end
