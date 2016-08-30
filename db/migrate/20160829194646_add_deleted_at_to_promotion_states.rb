# -*- encoding : utf-8 -*-
class AddDeletedAtToPromotionStates < ActiveRecord::Migration
  def change
    add_column :promotion_states, :deleted_at, :datetime
    add_index :promotion_states, :deleted_at
  end
end
