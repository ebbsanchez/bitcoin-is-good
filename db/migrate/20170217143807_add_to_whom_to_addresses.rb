class AddToWhomToAddresses < ActiveRecord::Migration
  def change
  	add_column :addresses, :to_id, :integer
  	add_column :addresses, :to_email, :string
  end
end
