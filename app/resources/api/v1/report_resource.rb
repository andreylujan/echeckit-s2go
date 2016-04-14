class Api::V1::ReportResource < JSONAPI::Resource
  attributes :title, :description, :dealer_id, :store_id,
    :zone_id
  def fetchable_fields
    super
  end
end
