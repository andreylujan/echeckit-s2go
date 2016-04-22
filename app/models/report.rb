# == Schema Information
#
# Table name: reports
#
#  id                 :integer          not null, primary key
#  organization_id    :integer          not null
#  report_type_id     :integer          not null
#  dynamic_attributes :json             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  creator_id         :integer          not null
#  limit_date         :datetime
#  finished           :boolean
#  assigned_user_id   :integer
#

class Report < ActiveRecord::Base
  belongs_to :organization
  belongs_to :report_type
  belongs_to :report_type
  belongs_to :creator, class_name: :User, foreign_key: :creator_id
  belongs_to :assigned_user, class_name: :User, foreign_key: :assigned_user_id
  mount_uploader :pdf, PdfUploader
  before_save :cache_data
  after_commit :generate_pdf, on: [ :create ]

  def generate_pdf
    UploadPdfJob.perform_later self.id
  end

  def pdf
    self.pdf.url
  end

  def cache_data
  	if self.dynamic_attributes.nil?
  		self.dynamic_attributes = {}
  	end
  	self.dynamic_attributes[:creator_name] = self.creator.full_name
  	self.dynamic_attributes[:report_type_name] = self.report_type.name
  end
end
