# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: promotions
#
#  id           :integer          not null, primary key
#  start_date   :datetime         not null
#  end_date     :datetime         not null
#  title        :text             not null
#  html         :text             not null
#  checklist_id :integer
#  creator_id   :integer          not null
#  deleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Promotion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
