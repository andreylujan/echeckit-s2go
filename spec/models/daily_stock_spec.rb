# == Schema Information
#
# Table name: daily_stocks
#
#  id              :integer          not null, primary key
#  brand_id        :integer
#  report_id       :integer
#  hardware_sales  :integer
#  accessory_sales :integer
#  game_sales      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe DailyStock, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
