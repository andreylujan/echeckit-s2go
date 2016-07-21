# == Schema Information
#
# Table name: monthly_sales
#
#  id              :integer          not null, primary key
#  store_id        :integer          not null
#  sales_date      :datetime         not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  hardware_sales  :integer          default(0), not null
#  accessory_sales :integer          default(0), not null
#  game_sales      :integer          default(0), not null
#

require 'rails_helper'

RSpec.describe MonthlySale, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
