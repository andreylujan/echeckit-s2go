# -*- encoding : utf-8 -*-
class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :zone, index: true, foreign_key: true, null: false
      t.references :dealer, index: true, foreign_key: true, null: false
      t.references :store, index: true, foreign_key: true, null: false
      t.datetime :arrival_time, null: false
      t.datetime :exit_time
      t.references :subsection, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
