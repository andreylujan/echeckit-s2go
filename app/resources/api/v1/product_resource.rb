class Api::V1::ProductResource < JSONAPI::Resource
	has_one :product_type
	has_one :product_destination
	has_many :platforms

	def self.records(options = {})
		context = options[:context]
		user = context[:current_user]
		org = user.organization
		Product.includes(product_type: :organization)
		.includes(:product_destination)
		.where(product_types: { organization_id: org.id })
	end
end
