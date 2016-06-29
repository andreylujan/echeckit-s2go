# -*- encoding : utf-8 -*-
class Api::V1::PlatformResource < BaseResource
  attributes :name
  has_one :brand
end
