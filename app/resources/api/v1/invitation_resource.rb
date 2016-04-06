class Api::V1::InvitationResource < JSONAPI::Resource
  attributes :email, :role_id

  def fetchable_fields
    super
  end
end
