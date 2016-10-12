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
#  uuid          :text
#  deleted_at    :datetime
#

class Image < ActiveRecord::Base

  acts_as_paranoid
  belongs_to :gallery
  belongs_to :user
  mount_base64_uploader :image, ImageUploader
  belongs_to :category
  belongs_to :report
  validates_presence_of [ :user, :image  ]
  belongs_to :resource, polymorphic: true
  before_create :set_uuid
  before_create :write_image_identifier
  before_create :set_comment
  skip_callback :save, :before, :write_image_identifier

  def zone_name
    if report.present?
      report.store.zone.name
    end
  end

  def set_comment
    if self.report.present?
      self.comment = self.report.get_comment_for_image(self)
    end
  end

  def store_name
    if report.present?
      report.store.name
    end
  end

  def dealer_name
    if report.present?
      report.store.dealer.name
    end
  end

  def creator_name
    user.name
  end

  def creator_email
    user.email
  end

  private
  def set_uuid
  	self.uuid = SecureRandom.uuid
  end
end
