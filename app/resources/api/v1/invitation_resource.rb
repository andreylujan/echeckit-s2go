# -*- encoding : utf-8 -*-
class Api::V1::InvitationResource < JSONAPI::Resource
  attributes :email, :role_id, :accepted

  def fetchable_fields
    super
  end
end
