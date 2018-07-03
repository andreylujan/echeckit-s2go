class CreateStockChartUploads < ActiveRecord::Migration
  def change
    create_table :stock_chart_uploads do |t|
      t.string :result_csv
      t.string :uploaded_csv
      t.datetime :stock_date
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :user_id
      t.integer :num_errors
      t.integer :num_total
    end
  end
end
