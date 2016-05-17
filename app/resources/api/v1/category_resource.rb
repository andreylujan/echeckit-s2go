class Api::V1::CategoryResource < JSONAPI::Resource
  attributes :name

  def self.records(options = {})
    context = options[:context]
    context[:current_user].organization.categories
  end

end
