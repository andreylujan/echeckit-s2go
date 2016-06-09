# == Schema Information
#
# Table name: product_types
#
#  id              :integer          not null, primary key
#  name            :text             not null
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ProductType < ActiveRecord::Base
  belongs_to :organization
  has_many :products
end
