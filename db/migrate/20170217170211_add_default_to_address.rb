class AddDefaultToAddress < ActiveRecord::Migration
  def change
  	change_column :addresses, :twd_amount, :integer, default: 0
  	change_column :addresses, :btc_amount, :float, default: 0.0
  	change_column :addresses, :btc_recieved, :float, default: 0.0
  	change_column :addresses, :notice, :boolean, default: false 
  end
end
