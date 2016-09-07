# -*- encoding : utf-8 -*-
class Api::V1::ReportProcessor < JSONAPI::Processor
  after_find do
    unless @result.is_a?(JSONAPI::ErrorsOperationResult)
      # finished_reports = Report.where()
      reports = Report.joins(creator: :role).where(roles: { id: context[:current_user].role_id })
      finished_reports_count = reports.where(finished: true).count
      @result.meta[:finished_reports_count] = finished_reports_count
      @result.meta[:pending_reports_count] = reports.count - finished_reports_count
    end
  end
end
