class SecundaryCategory < ActiveRecord::Base
  belongs_to :principalcategory
  has_many :categories
end
