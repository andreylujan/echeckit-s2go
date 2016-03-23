class Api::V1::UserResource < JSONAPI::Resource
    attributes :rut, :first_name, :last_name, :phone_number
end
