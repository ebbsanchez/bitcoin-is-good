class AddNoticeToTransaction < ActiveRecord::Migration
  def change
  	add_column :transactions, :notice, :boolean, default: false
  end
end
