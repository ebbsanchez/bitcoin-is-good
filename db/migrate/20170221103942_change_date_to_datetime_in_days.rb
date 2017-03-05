class ChangeDateToDatetimeInDays < ActiveRecord::Migration
  def change
  	change_column :days, :date, :datetime
  end
end
