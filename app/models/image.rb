# == Schema Information
#
# Table name: images
#
#  id           :integer          not null, primary key
#  url          :text
#  data_part_id :integer
#  user_id      :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Image < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :user
  # mount_base64_uploader :url, ImageUploader
  has_and_belongs_to_many :categories
end
