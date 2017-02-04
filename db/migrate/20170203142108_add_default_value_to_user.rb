class AddDefaultValueToUser < ActiveRecord::Migration
  def change
  	change_column :users, :level, :integer, default: 0
  	change_column :users, :balance, :real, default: 0
  	change_column :users, :lv1_pool, :real, default: 0
  	change_column :users, :lv2_pool, :real, default: 0
  	change_column :users, :lv3_pool, :real, default: 0
  	change_column :users, :lv4_pool, :real, default: 0
  	change_column :users, :lv5_pool, :real, default: 0
  	change_column :users, :lv6_pool, :real, default: 0
  	change_column :users, :lv7_pool, :real, default: 0

  end
end
