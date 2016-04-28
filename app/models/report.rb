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
#  pdf                :text
#

class Report < ActiveRecord::Base
  belongs_to :organization
  belongs_to :report_type
  belongs_to :report_type
  belongs_to :creator, class_name: :User, foreign_key: :creator_id
  belongs_to :assigned_user, class_name: :User, foreign_key: :assigned_user_id
  mount_uploader :pdf, PdfUploader
  has_many :images
  before_save :cache_data
  # after_commit :generate_pdf, on: [ :create ]
  validates :report_type_id, presence: true
  validates :report_type, presence: true

  def generate_pdf
    UploadPdfJob.perform_later self.id
  end

  def cache_data
  	if self.dynamic_attributes.nil?
  		self.dynamic_attributes = {}
  	end
  	self.dynamic_attributes[:creator_name] = self.creator.full_name
  	self.dynamic_attributes[:report_type_name] = self.report_type.name
  end

  def zone_name
    Zone.find(Report.last.dynamic_attributes["sections"][0]["data_section"][1]["zone_location"]["zone"]).name
  end

  def store_name
    Store.find(Report.last.dynamic_attributes["sections"][0]["data_section"][1]["zone_location"]["store"]).name
  end

  def dealer_name
    Dealer.find(Report.last.dynamic_attributes["sections"][0]["data_section"][1]["zone_location"]["dealer"]).name
  end

end
