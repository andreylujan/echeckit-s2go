# == Schema Information
#
# Table name: principalcategories
#
#  id              :integer          not null, primary key
#  name            :string
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Principalcategory < ActiveRecord::Base
  belongs_to :organization
end
