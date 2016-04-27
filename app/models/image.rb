# == Schema Information
#
# Table name: images
#
#  id           :integer          not null, primary key
#  image        :text
#  data_part_id :integer
#  user_id      :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  category_id  :integer
#

class Image < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :user
  mount_base64_uploader :image, ImageUploader
  belongs_to :category
  belongs_to :report
  validates_presence_of [ :user, :image ]
end
