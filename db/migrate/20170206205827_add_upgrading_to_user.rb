class AddUpgradingToUser < ActiveRecord::Migration
  def change
    add_column :users, :upgrading, :boolean, default: false
  end
end
