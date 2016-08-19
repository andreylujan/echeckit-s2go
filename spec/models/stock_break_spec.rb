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
#  deleted_at                :datetime
#

require 'rails_helper'

RSpec.describe StockBreak, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
