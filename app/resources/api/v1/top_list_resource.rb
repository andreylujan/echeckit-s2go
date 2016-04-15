class Api::V1::TopListResource < JSONAPI::Resource
  attributes :name
  has_many :top_list_items

  def fetchable_fields
    super
  end
end
