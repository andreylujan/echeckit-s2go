# -*- encoding : utf-8 -*-
class Api::V1::PromotionResource < JSONAPI::Resource
  attributes :title, :start_date, :end_date, :html, :dealer_ids, :zone_ids
  has_one :checklist, always_include_linkage_data: false
  before_create :set_creator

  has_many :users
  has_many :zones
  has_many :dealers
  has_many :images
  
  def set_creator(promotion = @model, context = @context)
    user = context[:current_user]
    promotion.creator = user
  end

 

end
