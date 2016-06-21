# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: stock_breaks
#
#  id                        :integer          not null, primary key
#  dealer_id                 :integer
#  store_type_id             :integer
#  product_classification_id :integer
#  stock_break               :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

class Api::V1::StockBreakResource < BaseResource
	attributes :stock_break
	has_one :store_type
	has_one :product_classification
	has_one :dealer
end
