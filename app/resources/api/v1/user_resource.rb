# -*- encoding : utf-8 -*-
class Api::V1::UserResource < JSONAPI::Resource
  attributes :rut, :first_name, :last_name, :phone_number,
    :password, :password_confirmation, :email, :role_id,
    :image, :role_name

  has_many :promotions

  filters :role_id
  filter :zone_ids, apply: ->(records, value, _options) {
    records.joins(:promoted_stores)
      .where(stores: { zone_id: value })
  }
  filter :dealer_ids, apply: ->(records, value, _options) {
    records.joins(:promoted_stores)
      .where(stores: { dealer_id: value })
  }
  filter :store_ids, apply: ->(records, value, _options) {
    records.joins(:promoted_stores)
      .where(stores: { id: value })
  }
  def role_name
    @model.organization.name
  end

  def fetchable_fields
    super - [ :password, :password_confirmation ]
  end

end
