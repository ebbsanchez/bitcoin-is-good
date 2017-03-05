class AddUsageToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :usage, :string
  end
end
