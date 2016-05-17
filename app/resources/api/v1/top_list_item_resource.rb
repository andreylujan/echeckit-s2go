class Api::V1::TopListItemResource < JSONAPI::Resource
  attributes :name, :images, :platform_ids

  def fetchable_fields
    super
  end
end
