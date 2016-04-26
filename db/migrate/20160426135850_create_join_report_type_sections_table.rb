class CreateJoinReportTypeSectionsTable < ActiveRecord::Migration
  def change
    create_join_table :report_types, :sections do |t|
    	t.index :report_type_id
    	t.index :section_id
    end
  end
end
