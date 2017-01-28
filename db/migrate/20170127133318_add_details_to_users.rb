class AddDetailsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :level, :integer
  	add_column :users, :balance, :integer
  	add_column :users, :line_id, :text
  end
end
