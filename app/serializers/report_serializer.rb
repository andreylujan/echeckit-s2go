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

class ReportSerializer < ActiveModel::Serializer
    attributes :id, :created_at, :updated_at, :dynamic_attributes, :creator_id,
    	:finished, :assigned_user_id, :pdf, :pdf_uploaded

    def pdf
    	object.pdf.url
    end
end
