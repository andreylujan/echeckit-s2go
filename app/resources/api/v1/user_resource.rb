class Api::V1::UserResource < JSONAPI::Resource
  attributes :rut, :first_name, :last_name, :phone_number,
    :password, :password_confirmation, :email, :role_id,
    :image, :role_name

  def role_name
  	@model.organization.name
  end

  def fetchable_fields
    super - [ :password, :password_confirmation ]
  end

  filter :organization_id, apply: ->(records, value, _options) {
  		User.all.includes(:role).where(roles: { organization_id: value })
	}
end
