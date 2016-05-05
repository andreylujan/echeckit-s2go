class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.text :title, null: false
      t.text :html, null: false
      t.references :data_part, index: true, foreign_key: true, null: false
      t.integer :creator_id, null: false
      t.datetime :deleted_at

      t.timestamps null: false
    end
    add_index :promotions, :deleted_at
    add_index :promotions, :creator_id
  end
end
