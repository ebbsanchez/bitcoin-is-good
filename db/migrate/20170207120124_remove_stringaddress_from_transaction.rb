class RemoveStringaddressFromTransaction < ActiveRecord::Migration
  def change
  	remove_column :transactions, :address
  end
end
