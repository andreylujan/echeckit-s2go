# == Schema Information
#
# Table name: secundary_categories
#
#  id                   :integer          not null, primary key
#  name                 :string
#  principalcategory_id :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class SecundaryCategory < ActiveRecord::Base
  belongs_to :principalcategory
  has_many :categories
end
