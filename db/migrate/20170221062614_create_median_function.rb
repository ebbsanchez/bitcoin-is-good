class CreateMedianFunction < ActiveRecord::Migration
  def change
    create_table :median_functions do |t|
    end
    ActiveMedian.create_function
  end
end
