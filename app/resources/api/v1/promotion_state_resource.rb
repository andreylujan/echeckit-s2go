class Api::V1::PromotionStateResource < BaseResource
  attributes :activated_at, :store_name, :dealer_name, :zone_name,
    :pdf, :pdf_uploaded, :activated, :activated_at,
    :activator_name, :creator_name, :promotion_id,
    :start_date, :end_date, :title

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

end
