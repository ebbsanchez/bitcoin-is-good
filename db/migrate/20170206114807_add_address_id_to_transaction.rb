class AddAddressIdToTransaction < ActiveRecord::Migration
  def change
  	add_column :transactions, :address_id, :string
  end
end
