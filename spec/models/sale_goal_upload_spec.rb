# == Schema Information
#
# Table name: sale_goal_uploads
#
#  id           :integer          not null, primary key
#  result_csv   :text
#  uploaded_csv :text
#  goal_date    :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe SaleGoalUpload, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end