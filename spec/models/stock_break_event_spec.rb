# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: stock_break_events
#
#  id                   :integer          not null, primary key
#  store_id             :integer          not null
#  product_id           :integer          not null
#  quantity             :integer          not null
#  stock_break_date     :datetime         not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  stock_break_quantity :integer
#

require 'rails_helper'

RSpec.describe StockBreakEvent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
