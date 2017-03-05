class AddDefaultValueToTransaction < ActiveRecord::Migration
  def change
  	change_column :transactions, :pending, :boolean, default: false
  	change_column :transactions, :complete, :boolean, default: false
  	change_column :transactions, :btc_recieved, :real, default: 0.0
  end
end
