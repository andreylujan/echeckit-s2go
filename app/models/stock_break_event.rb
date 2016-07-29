# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: stock_break_events
#
#  id               :integer          not null, primary key
#  store_id         :integer          not null
#  product_id       :integer          not null
#  quantity         :integer          not null
#  stock_break_date :datetime         not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class StockBreakEvent < ActiveRecord::Base
  belongs_to :store
  belongs_to :product
  validates :store, presence: true
  validates :quantity, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: false
  validates :stock_break_date, presence: true
  validates :product, presence: true
end
