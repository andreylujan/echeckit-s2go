# == Schema Information
#
# Table name: weekly_business_sales
#
#  id              :integer          not null, primary key
#  store_id        :integer          not null
#  business_week   :integer          not null
#  month           :integer          not null
#  hardware_sales  :integer          default(0), not null
#  accessory_sales :integer          default(0), not null
#  game_sales      :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe WeeklyBusinessSale, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
