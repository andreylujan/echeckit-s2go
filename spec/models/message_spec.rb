# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  broadcast_id :integer          not null
#  user_id      :integer          not null
#  read         :boolean          default(FALSE), not null
#  read_at      :datetime
#  deleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Message, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
