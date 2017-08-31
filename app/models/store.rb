# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: stores
#
#  id               :integer          not null, primary key
#  name             :text             not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  contact          :text
#  phone_number     :text
#  address          :text
#  zone_id          :integer
#  dealer_id        :integer
#  deleted_at       :datetime
#  monthly_goal_clp :integer
#  monthly_goal_usd :decimal(8, 2)
#  store_type_id    :integer
#  code             :text
#  supervisor_id    :integer
#  instructor_id    :integer
#  store_manager    :text
#  floor_manager    :text
#  visual           :text
#  area_salesperson :text
#

class Store < ActiveRecord::Base

  belongs_to :zone
  belongs_to :dealer

  belongs_to :store_type
  belongs_to :supervisor, class_name: :User, foreign_key: :supervisor_id
  belongs_to :instructor, class_name: :User, foreign_key: :instructor_id

  acts_as_paranoid

  validates_presence_of [ :name, :zone, :dealer ]
  validates :monthly_goal_clp, numericality: { only_integer: true }, allow_nil: true
  validates :monthly_goal_usd, numericality: true, allow_nil: true

  has_many :promotion_states, dependent: :destroy
  has_many :sale_goals, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :weekly_business_sales, dependent: :destroy
  has_and_belongs_to_many :promoters, class_name: 'User'
  has_many :checkins, dependent: :destroy
  validates :code, presence: true
  
  default_scope { order('name ASC') }
  
  def self.from_csv(csv_path, reset = false)
  	stores = []
    Store.transaction do
      if reset
        Store.with_deleted.all.each { |s| s.really_destroy! }
        Zone.with_deleted.all.each { |z| z.really_destroy! }
        Dealer.with_deleted.all.each { |d| d.really_destroy! }
      end

      csv = CsvUtils.load_csv(csv_path)
      csv.shift
      supervisor_role = Role.find_by_name! "Supervisor"
      instructor_role = Role.find_by_name! "Instructor"
      csv.each do |row|
        if row[0].present?
          store = Store.find_or_initialize_by(code: row[0])
          dealer = Dealer.find_or_create_by_lowercase_name! row[1]
          name = row[2]
          zone = Zone.find_or_create_by_lowercase_name! row[3]
          store_type = StoreType.find_or_create_by_lowercase_name! row[4]
          if row[5].present?
            instructor = User.find_or_create_by_lowercase_email! row[5], instructor_role
            instructor.update_attributes! first_name: row[6]
            store.instructor = instructor
          end

          if row[7].present?
            supervisor = User.find_or_create_by_lowercase_email! row[7], supervisor_role
            supervisor.update_attributes! first_name: row[8]
            store.supervisor = supervisor
          end

          store.assign_attributes dealer: dealer, name: name, zone: zone,
          	store_type: store_type

          store.save!
          stores << store
        end
      end

      Dealer.all.each do |d|
      	zone_ids = d.zone_ids
      	d.stores.each do |store|
      		zone_ids << store.zone_id
      	end
      	d.zone_ids = zone_ids.uniq
      	d.save!
      end
    end
    stores
  end
end
