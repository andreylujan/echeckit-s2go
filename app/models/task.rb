# -*- encoding : utf-8 -*-
class Task
  include ActiveModel::Model

  attr_accessor :id, :store_id, :creator_id, :task_start,
    :task_end, :title, :description, :assigned_user_ids,
    :dealer_ids, :zone_ids

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
