# -*- encoding : utf-8 -*-
class AddSupervisorIdAndInstructorIdToStores < ActiveRecord::Migration
  def change
    add_column :stores, :supervisor_id, :integer
    add_index :stores, :supervisor_id
    add_column :stores, :instructor_id, :integer
    add_index :stores, :instructor_id
  end
end
