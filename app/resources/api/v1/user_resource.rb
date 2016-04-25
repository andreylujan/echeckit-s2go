class Api::V1::UserResource < JSONAPI::Resource
  attributes :rut, :first_name, :last_name, :phone_number,
    :password, :password_confirmation, :email, :role_id,
    :image

  def fetchable_fields
    super - [ :password, :password_confirmation ]
  end
end
