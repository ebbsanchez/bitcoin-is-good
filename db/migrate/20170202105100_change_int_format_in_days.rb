class ChangeIntFormatInDays < ActiveRecord::Migration
  def change
  	change_column :days, :balance, :real
  end
end
