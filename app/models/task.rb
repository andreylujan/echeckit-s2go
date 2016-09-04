# -*- encoding : utf-8 -*-
class Task

  include ActiveModel::Model
  include ActiveModel::Associations

  attr_accessor :id, :store_id, :creator_id, :task_start,
    :task_end, :title, :description, :promoter_ids,
    :dealer_ids, :zone_ids, :store_ids,
    :creator_id, :report_ids, :result

  has_many :reports
  has_many :zones
  has_many :dealers
  has_many :stores
  has_many :promoters, class_name: 'User'
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id

  def save(*args)
    self.id = SecureRandom.uuid
    new_reports = []
    if promoters.count > 0
      promoters.each do |promoter|
        if stores.count > 0
          stores.each do |store|
            new_reports << report_from_store_and_promoter(store, promoter)
          end
        else
          promoter.promoted_stores.each do |store|
            new_reports << report_from_store_and_promoter(store, promoter)
          end
        end
      end
    elsif stores.count > 0
      new_reports = new_reports + reports_from_stores(stores)
    else
      stores = Store.all
      if zones.count > 0
        stores = stores.where(zone_id: zone_ids)
      end
      if dealers.count > 0
        stores = stores.where(dealer_id: dealer_ids)
      end
      new_reports = new_reports + reports_from_stores(stores)
    end

    push_ids = []
    Report.transaction do
      new_reports.group_by(&:assigned_user_id).each do |assigned_user_id, group|
        group.each_with_index do |report, idx|
          report.skip_push = true
          report.save!
          if idx == 0
            push_ids << report.id
          end
        end
      end
    end

    push_ids.each do |report_id|
      SendTaskJob.set(queue: "#{Rails.env}_eretail_push").perform_later(report_id)
    end

    self.result = {
      num_reports_assigned: reports.length,
    }
    true
  end

  def reports_from_stores(stores)
    new_reports = []
    stores.each do |store|
      if store.promoter.present?
        new_reports << report_from_store_and_promoter(store, store.promoter)
      elsif store.instructor.present?
        new_reports << report_from_store_and_promoter(store, store.instructor)
      elsif store.supervisor.present?
        new_reports << report_from_store_and_promoter(store, store.supervisor)
      end
    end
    new_reports
  end

  def report_from_store_and_promoter(store, promoter)
    Report.new(
      creator: creator,
      assigned_user: promoter,
      title: title,
      description: description,
      store: store,
      report_type_id: 1,
      task_start: task_start,
      limit_date: task_end
    )
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
