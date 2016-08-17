# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: stock_breaks
#
#  id                        :integer          not null, primary key
#  dealer_id                 :integer
#  store_type_id             :integer
#  product_classification_id :integer
#  stock_break               :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

class StockBreak < ActiveRecord::Base
  belongs_to :dealer
  belongs_to :store_type
  belongs_to :product_classification

  validates :stock_break, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :dealer, presence: true
  validates :store_type, presence: true
  validates :product_classification, presence: true

  acts_as_xlsx columns: [ :id, :dealer_name, :product_classification_name,
                          :stock_break ]

  def dealer_name
  	dealer.name
  end

  def product_classification_name
  	product_classification.name
  end
  
end
