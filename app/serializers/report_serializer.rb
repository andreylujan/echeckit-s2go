# -*- encoding : utf-8 -*-
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
#  finished           :boolean          default(FALSE), not null
#  assigned_user_id   :integer
#  pdf                :text
#  pdf_uploaded       :boolean          default(FALSE), not null
#  uuid               :text
#  store_id           :integer
#  deleted_at         :datetime
#  finished_at        :datetime
#  task_start         :datetime
#  title              :text
#  description        :text
#

class ReportSerializer < ActiveModel::Serializer
    attributes :id, :created_at, :updated_at, :dynamic_attributes, :creator_id,
    	:finished, :assigned_user_id, :pdf, :pdf_uploaded, :limit_date

    def pdf
    	object.pdf.url
    end
end
