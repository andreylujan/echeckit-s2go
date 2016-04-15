class Api::V1::TopListItemResource < JSONAPI::Resource
  attributes :name, :images
  def fetchable_fields
    super
  end
end
