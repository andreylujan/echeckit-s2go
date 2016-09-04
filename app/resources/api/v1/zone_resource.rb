# -*- encoding : utf-8 -*-
class Api::V1::ZoneResource < BaseResource
  
  attributes :name, :dealer_ids

  has_many :dealers
  has_many :stores
  has_many :promotions
  
  filter :dealer_ids, apply: ->(records, value, _options) {
    if value.is_a? Array and value.length > 0
      records.joins(:dealers)
        .where(dealers: { id: value })
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

  filter :promoter_ids, apply: ->(records, value, _options) {
    if value.is_a? Array and value.length > 0
      records.joins(:stores)
        .where(stores: { promoter_id: value })
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
