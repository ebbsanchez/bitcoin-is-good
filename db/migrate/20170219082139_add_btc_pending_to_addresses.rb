class AddBtcPendingToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :btc_pending, :float, default: 0.0
  end
end
