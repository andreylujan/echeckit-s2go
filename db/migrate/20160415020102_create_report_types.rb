class CreateReportTypes < ActiveRecord::Migration
  def change
    create_table :report_types do |t|
      t.text :name
      t.references :organization, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
