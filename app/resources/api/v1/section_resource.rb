class Api::V1::SectionResource < JSONAPI::Resource
  attributes :name

  def fetchable_fields
    super
  end
end
