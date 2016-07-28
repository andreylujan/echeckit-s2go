# == Schema Information
#
# Table name: daily_head_counts
#
#  id            :integer          not null, primary key
#  store_id      :integer
#  count_date    :datetime
#  num_full_time :integer          default(0), not null
#  num_part_time :integer          default(0), not null
#  brand_id      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe DailyHeadCount, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end