# -*- encoding : utf-8 -*-
class Api::V1::UserResource < BaseResource
  attributes :rut, :first_name, :last_name, :phone_number,
    :password, :password_confirmation, :email, :role_id,
    :image, :role_name

  has_many :promotions

  filters :role_id
  filter :zone_ids, apply: ->(records, value, _options) {
    if value.is_a? Array and value.length > 0
      records.joins(:promoted_stores)
      .where(stores: { zone_id: value })
    else
      records
    end
  }
  filter :dealer_ids, apply: ->(records, value, _options) {
    if value.is_a? Array and value.length > 0
      records.joins(:promoted_stores)
      .where(stores: { dealer_id: value })
    else
      records
    end
  }
  filter :store_ids, apply: ->(records, value, _options) {
    if value.is_a? Array and value.length > 0
      records.joins(:promoted_stores)
      .where(stores: { id: value })
    else
      records
    end
  }

  def self.records(options = {})
    context = options[:context]
    if context[:promoters_only]
      # user_ids = User.joins(:promoted_stores).map { |u| u.id } + User.where(role_id: 2).map { |u| u.id }
      # user_ids.uniq!
      # users = User.where(id: user_ids)
      users = User.joins(:promoted_stores).uniq
      if not options[:sort_criteria].present?
        users = users.order('first_name, last_name')
      end
      users
    else
      super
    end    
  end

  def role_name
    @model.role.name
  end

  def fetchable_fields
    super - [ :password, :password_confirmation ]
  end

end
