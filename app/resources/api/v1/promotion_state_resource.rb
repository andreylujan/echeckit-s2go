# -*- encoding : utf-8 -*-
class Api::V1::PromotionStateResource < BaseResource
  attributes :activated_at, :store_name, :dealer_name, :zone_name,
    :pdf, :pdf_uploaded, :activated,
    :activator_name, :creator_name, :promotion_id,
    :start_date, :end_date, :title

  filter :activated_at, apply: ->(records, value, _options) {
    if value.empty?
      records
    else
      records.where("to_char(promotion_states.activated_at, 'DD/MM/YYYY HH:MI') similar to '%(" + value.join("|") + ")%'")
    end
  }

  filter :start_date, apply: ->(records, value, _options) {
    if value.empty?
      return records
    end
    records.joins(:promotion)
    .where("to_char(promotions.start_date, 'DD/MM/YYYY HH:MI') similar to '%(" + value.join("|") + ")%'")
  }

  filter :end_date, apply: ->(records, value, _options) {
    if value.empty?
      return records
    end
    records.joins(:promotion)
    .where("to_char(promotion_states.end_date, 'DD/MM/YYYY HH:MI') similar to '%(" + value.join("|") + ")%'")
  }

  filter :title, apply: ->(records, value, _options) {
    if value.empty?
      return records
    end
    records.joins(:promotion)
    .where("promotions.title similar to '%(" + value.join("|") + ")%'")
  }

  filter :activated, apply: ->(records, value, _options) {
    if value.is_a? Array and value.length > 0
      if value
        records.where("activated_at is not null")
      else
        records.where("activated_at is null")
      end
    else
      records
    end
  }

  filter :id, apply: ->(records, value, _options) {
    records.where("to_char(promotion_states.id, '999999999D') ILIKE ?", "%#{value.first}%")
  }

  filter :zone_name, apply: ->(records, value, _options) {
    records.joins(store: :zone).where("zones.name ILIKE ?", "%#{value.first}%")
  }

  filter :store_name, apply: ->(records, value, _options) {
    records.joins(:store).where('stores.name ILIKE ?', "%#{value.first}%")
  }

  filter :dealer_name, apply: ->(records, value, _options) {
    records.joins(store: :dealer).where("dealers.name ILIKE ?", "%#{value.first}%")
  }

  filter :creator_name, apply: ->(records, value, _options) {
    records.includes(promotion: :creator)
    .where('users.first_name || users.last_name ILIKE ?', "%#{value.first}%")
    .references(:creator)
  }

  filter :activator_name, apply: ->(records, value, _options) {
    records
  }


end
