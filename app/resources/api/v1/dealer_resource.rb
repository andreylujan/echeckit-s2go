# -*- encoding : utf-8 -*-
class Api::V1::DealerResource < JSONAPI::Resource
  attributes :name, :contact, :phone_number, :address,
  :store_ids

  has_many :zones
  has_many :stores
  has_many :promotions
  has_many :stock_breaks
 
  filter :zone_id, apply: ->(records, value, _options) {
    records.joins(:zones).where(zones: { id: value })
  }

  filter :zone_ids, apply: ->(records, value, _options) {
    if value.is_a? Array and value.length > 0
      records.joins(:zones)
        .where(zones: { id: value })
    else
      records
    end
  }

  filter :store_ids, apply: ->(records, value, _options) {
    if value.is_a? Array and value.length > 0
      records.joins(:stores)
        .where(stores: { id: value })
    else
      records
    end
  }

  def fetchable_fields
    super
  end

  def self.updatable_fields(context)
    super - [:stores]
  end

  def self.creatable_fields(context)
    super - [:stores]
  end

end
