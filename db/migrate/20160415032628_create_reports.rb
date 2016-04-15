class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :organization, index: true, foreign_key: true, null: false
      t.references :report_type, index: true, foreign_key: true, null: false
      t.json :data, null: false, default: {}

      t.timestamps null: false
    end
  end
end
