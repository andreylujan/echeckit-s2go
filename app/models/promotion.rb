# == Schema Information
#
# Table name: promotions
#
#  id           :integer          not null, primary key
#  start_date   :datetime         not null
#  end_date     :datetime         not null
#  title        :text             not null
#  html         :text             not null
#  data_part_id :integer          not null
#  creator_id   :integer          not null
#  deleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Promotion < ActiveRecord::Base
	acts_as_paranoid
	belongs_to :creator, class_name: :User, foreign_key: :creator_id
	belongs_to :checklist
	validates_presence_of [ :start_date, :end_date, :title, :html, :creator, :checklist ]

	has_and_belongs_to_many :users
	has_and_belongs_to_many :zones
	has_and_belongs_to_many :dealers
end
