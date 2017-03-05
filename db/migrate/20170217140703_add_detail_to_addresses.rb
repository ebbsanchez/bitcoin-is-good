class AddDetailToAddresses < ActiveRecord::Migration
  def change
  	add_column :addresses, :twd_amount, :integer
  	add_column :addresses, :btc_amount, :float
  	add_column :addresses, :btc_amount_expired, :datetime
  	add_column :addresses, :btc_recieved, :float
  	add_column :addresses, :status, :string
  	add_column :addresses, :notice, :boolean
  end
end
