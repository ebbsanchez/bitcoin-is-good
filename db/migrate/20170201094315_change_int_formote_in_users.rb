class ChangeIntFormoteInUsers < ActiveRecord::Migration
  def change
  	change_column :users, :balance, :real
  end
end
