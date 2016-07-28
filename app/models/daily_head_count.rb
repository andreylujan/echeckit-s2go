# == Schema Information
#
# Table name: daily_head_counts
#
#  id            :integer          not null, primary key
#  store_id      :integer
#  count_date    :datetime
#  num_full_time :integer          default(0), not null
#  num_part_time :integer          default(0), not null
#  brand_id      :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class DailyHeadCount < ActiveRecord::Base
  belongs_to :store
  belongs_to :brand

  validates :store, presence: true
  validates :brand, presence: true

  validates :num_full_time, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: false
  validates :num_part_time, :numericality => { :greater_than_or_equal_to => 0 }, allow_nil: false

  def group_by_dealer_criteria
    store.dealer
    # I18n.l(created_at, format: '%A %e').capitalize
  end

  def group_by_store_criteria
    store
    # I18n.l(created_at, format: '%A %e').capitalize
  end
end
