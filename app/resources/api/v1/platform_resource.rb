class Api::V1::PlatformResource < JSONAPI::Resource
  attributes :name

  def self.records(options = {})
    context = options[:context]
    context[:current_user].organization.platforms
  end
end
