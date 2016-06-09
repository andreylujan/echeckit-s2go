# == Schema Information
#
# Table name: products
#
#  id                     :integer          not null, primary key
#  name                   :text             not null
#  description            :text
#  sku                    :text
#  plu                    :text
#  validity_code          :text
#  product_type_id        :integer          not null
#  brand                  :text
#  min_price              :integer
#  max_price              :integer
#  stock                  :integer
#  product_destination_id :integer          not null
#  is_top                 :boolean          default(FALSE), not null
#  is_listed              :boolean          default(FALSE), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Product < ActiveRecord::Base
  belongs_to :product_type
  belongs_to :product_destination
  has_and_belongs_to_many :platforms
  validates :min_price, :numericality => { :greater_than_or_equal_to => 0 }
  validates_numericality_of :max_price, 
  	greater_than_or_equal_to: Proc.new { |product| product.min_price }

  validates :product_type, presence: true
  validates :product_destination, presence: true
  validates :name, presence: true
  validates :sku, uniqueness: true, allow_nil: true


end
