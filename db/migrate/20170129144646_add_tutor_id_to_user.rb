class AddTutorIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :tutor_id, :smallint
  end
end
