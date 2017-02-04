class AddPoolsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :lv1_pool, :real
  	add_column :users, :lv2_pool, :real
  	add_column :users, :lv3_pool, :real
  	add_column :users, :lv4_pool, :real
  	add_column :users, :lv5_pool, :real
  	add_column :users, :lv6_pool, :real
  	add_column :users, :lv7_pool, :real
  end
end
