# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: products
#
#  id                     :integer          not null, primary key
#  name                   :text             not null
#  description            :text
#  sku                    :text
#  plu                    :text
#  validity_code          :text
#  product_type_id        :integer          not null
#  brand                  :text
#  min_price              :integer
#  max_price              :integer
#  stock                  :integer
#  product_destination_id :integer          not null
#  is_top                 :boolean          default(FALSE), not null
#  is_listed              :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Api::V1::ProductResource < BaseResource

	attributes :name, :description, :sku, :plu, :validity_code,
		:brand, :min_price, :max_price, :stock, :is_top,
		:is_listed, :created_at

	has_one :product_type
	has_one :product_destination
	has_many :platforms
	has_many :images

	filters :is_listed, :is_top

end
