# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: products
#
#  id                        :integer          not null, primary key
#  name                      :text             not null
#  description               :text
#  sku                       :text
#  plu                       :text
#  validity_code             :text
#  product_type_id           :integer          not null
#  brand                     :text
#  min_price                 :integer
#  max_price                 :integer
#  product_classification_id :integer          not null
#  is_top                    :boolean          default(FALSE), not null
#  is_listed                 :boolean          default(FALSE), not null
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  platform_id               :integer
#  publisher                 :text
#  deleted_at                :string
#  catalogued                :boolean          default(TRUE), not null
#

require 'rails_helper'

RSpec.describe Product, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
