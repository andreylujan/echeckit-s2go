class CreateJoinTablesForPromotions < ActiveRecord::Migration
  def change
  	create_join_table :promotions, :users do |t|
    	t.index :promotion_id
    	t.index :user_id
    end
    create_join_table :promotions, :zones do |t|
    	t.index :promotion_id
    	t.index :zone_id
    end
    create_join_table :promotions, :dealers do |t|
    	t.index :promotion_id
    	t.index :dealer_id
    end
  end
end
