# -*- encoding : utf-8 -*-
class Api::V1::UserResource < JSONAPI::Resource
  attributes :rut, :first_name, :last_name, :phone_number,
    :password, :password_confirmation, :email, :role_id,
    :image, :role_name

  has_many :promotions
  
  def role_name
  	@model.organization.name
  end

  def fetchable_fields
    super - [ :password, :password_confirmation ]
  end

end
