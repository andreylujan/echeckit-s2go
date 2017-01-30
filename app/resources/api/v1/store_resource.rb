# -*- encoding : utf-8 -*-
class Api::V1::StoreResource < BaseResource
  attributes :name, :contact, :phone_number, :address,
  	:dealer_id, :zone_id, :monthly_goal_usd, :monthly_goal_clp,
    :code, :store_manager, :floor_manager, :visual, :area_salesperson

  has_one :zone
  has_one :dealer
  has_one :store_type
  has_one :supervisor
  has_one :instructor
  has_many :promoters

  filters :zone_id, :dealer_id, :name

  filter :zone_ids, apply: ->(records, value, _options) {
    if value.is_a? Array and value.length > 0
      records.where(zone_id: value)
    else
      records
    end
  }

  filter :dealer_ids, apply: ->(records, value, _options) {
    if value.is_a? Array and value.length > 0
      records.where(dealer_id: value)
    else
      records
    end
  }

  filter :promoter_ids, apply: ->(records, value, _options) {
   
    if value.is_a? Array and value.length > 0
      records.joins(:promoters).where(users: { id: value }).uniq
    else
      records
    end
  }

  def fetchable_fields
    super
  end
end
