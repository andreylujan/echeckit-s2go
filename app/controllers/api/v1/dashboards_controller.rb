class Api::V1::DashboardsController < Api::V1::JsonApiController
  def sales
  	month = params.require(:month)
  	year = params.require(:year)

  	report = SalesReport.find_by(month: month, year: year)
  	render json: JSONAPI::ResourceSerializer.new(Api::V1::SalesReportResource)
  		.serialize_to_hash(Api::V1::SalesReportResource.new(report, nil))
  end
end
