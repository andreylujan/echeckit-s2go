# -*- encoding : utf-8 -*-
class CreatePromotionStates < ActiveRecord::Migration
  def change
    create_table :promotion_states do |t|
      t.references :promotion, index: true, foreign_key: true, null: false
      t.references :store, index: true, foreign_key: true, null: false
      t.datetime :activated_at
      t.references :report, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :promotion_states, :activated_at
  end
end
