# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: checklist_item_values
#
#  id                :integer          not null, primary key
#  report_id         :integer          not null
#  item_value        :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  checklist_item_id :integer          not null
#  image_list        :json
#

class ChecklistItemValue < ActiveRecord::Base
  belongs_to :report
  validates :report, presence: true
  belongs_to :checklist_item
  # validates :item_value, inclusion: { in: [ true, false ] }

  def group_by_store_criteria
    report.store
    # I18n.l(created_at, format: '%A %e').capitalize
  end

  def group_by_date_criteria
  	report.created_at.to_date
  end
end
