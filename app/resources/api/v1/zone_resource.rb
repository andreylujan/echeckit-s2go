# -*- encoding : utf-8 -*-
class Api::V1::ZoneResource < JSONAPI::Resource
    
  attributes :name, :dealer_ids

  has_many :dealers
  has_many :stores
  has_many :promotions
  
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
