class UserSerializer < ActiveModel::Serializer
  attributes :email, :first_name, :last_name, :full_name, 
    :rut, :address, :picture
end