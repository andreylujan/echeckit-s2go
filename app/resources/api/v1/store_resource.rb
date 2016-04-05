class Api::V1::StoreResource < JSONAPI::Resource
  attributes :name

  def fetchable_fields
    super
  end
end
