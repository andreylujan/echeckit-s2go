# -*- encoding : utf-8 -*-
class Task

  include ActiveModel::Model
  include ActiveModel::Associations

  attr_accessor :id, :store_id, :creator_id, :task_start,
    :task_end, :title, :description, :promoter_ids,
    :dealer_ids, :zone_ids, :store_ids, :all_promoters

  has_many :zones
  has_many :dealers
  has_many :stores
  has_many :promoters

  def save(*args)
    self.id = SecureRandom.uuid
    true
  end

  # need hash like accessor, used internal Rails
  def [](attr)
    self.send(attr)
  end

  # need hash like accessor, used internal Rails
  def []=(attr, value)
    self.send("#{attr}=", value)
  end

end
