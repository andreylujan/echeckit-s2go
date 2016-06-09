# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: images
#
#  id            :integer          not null, primary key
#  image         :text
#  data_part_id  :integer
#  user_id       :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  category_id   :integer
#  report_id     :integer
#  detail_id     :integer
#  resource_id   :integer
#  resource_type :text
#

class Image < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :user
  mount_base64_uploader :image, ImageUploader
  belongs_to :category
  belongs_to :report
  validates_presence_of [ :user, :image  ]
  belongs_to :resource, polymorphic: true

  before_create :write_image_identifier
  skip_callback :save, :before, :write_image_identifier

end
