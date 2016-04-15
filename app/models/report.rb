# == Schema Information
#
# Table name: reports
#
#  id              :integer          not null, primary key
#  organization_id :integer          not null
#  report_type_id  :integer          not null
#  data            :json             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Report < ActiveRecord::Base
  belongs_to :organization
  belongs_to :report_type
  belongs_to :report_type
end
