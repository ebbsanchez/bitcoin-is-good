class AddDefaultToAddresses < ActiveRecord::Migration
  def change
  	change_column :addresses, :status, :string, default: 'waiting'
  end
end
