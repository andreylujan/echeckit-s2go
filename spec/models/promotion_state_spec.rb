# == Schema Information
#
# Table name: promotion_states
#
#  id           :integer          not null, primary key
#  promotion_id :integer          not null
#  store_id     :integer          not null
#  activated_at :datetime
#  report_id    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe PromotionState, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
