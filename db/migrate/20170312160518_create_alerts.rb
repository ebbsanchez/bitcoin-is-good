class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.text :usage
      t.text :data

      t.timestamps null: false
    end
  end
end
