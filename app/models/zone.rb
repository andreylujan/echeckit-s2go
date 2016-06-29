# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: zones
#
#  id         :integer          not null, primary key
#  name       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  deleted_at :datetime
#

class Zone < ActiveRecord::Base

	acts_as_paranoid

    has_and_belongs_to_many :dealers
    has_many :stores, dependent: :destroy
    has_and_belongs_to_many :promotions

    validates_presence_of :name
    validates_uniqueness_of :name

    include NameCreatable

    default_scope { order('name ASC') }
end
