# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: daily_product_sales
#
#  id         :integer          not null, primary key
#  product_id :integer
#  quantity   :integer          default(0), not null
#  amount     :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  report_id  :integer
#

require 'rails_helper'

RSpec.describe DailyProductSale, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
