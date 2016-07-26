# == Schema Information
#
# Table name: daily_product_sales
#
#  id         :integer          not null, primary key
#  product_id :integer
#  store_id   :integer
#  sales_date :datetime         not null
#  quantity   :integer          not null
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe DailyProductSale, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
