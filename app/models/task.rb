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
    reports_by_user = {}

    # Si se indican promotores explícitamente, se prioriza esto
    if promoters.count > 0
      promoters.each do |promoter|
        if stores.count > 0
          stores.each do |store|
            new_reports << report_from_store_and_promoters(store, [promoter])
          end
        else
          promoter.promoted_stores.each do |store|
            new_reports << report_from_store_and_promoters(store, [promoter])
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

    Report.transaction do
      new_reports.each do |new_report|
        new_report.assigned_user_ids.each do |assigned_user_id|
          if not reports_by_user[assigned_user_id]
            reports_by_user[assigned_user_id] = new_report
          end
        end
        new_report.skip_push = true
        new_report.save!
      end
    end
    reports_by_user.each do |user_id, report|
      SendTaskJob.set(queue: "#{Rails.env}_eretail_push").perform_later(report.id, user_id)
    end

    self.result = {
      num_reports_assigned: new_reports.length,
    }
    true
  end

  def reports_from_stores(stores)
    new_reports = []
    stores.each do |store|
      store_promoters = []

      # Assign to each promoter
      if store.promoters.count > 0
        store.promoters.each do |promoter|
          store_promoters << promoter
        end
      end

      # Assign to instructor
      if store.instructor.present?
        store_promoters << store.instructor
      end

      # Assign to supervisor
      if store.supervisor.present?
        store_promoters << store.supervisor
      end
      new_reports << report_from_store_and_promoters(store, store_promoters.uniq)
    end
    new_reports
  end

  def report_from_store_and_promoters(store, promoters)
    Report.new(
      creator: creator,
      assigned_users: promoters,
      title: title,
      description: description,
      store: store,
      report_type_id: 1,
      task_start: task_start,
      limit_date: task_end,
      is_task: true
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
