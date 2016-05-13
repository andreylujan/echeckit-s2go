# == Schema Information
#
# Table name: images
#
#  id            :integer          not null, primary key
#  image         :text
#  data_part_id  :integer
#  user_id       :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  category_id   :integer
#  report_id     :integer
#  detail_id     :integer
#  resource_id   :integer
#  resource_type :text
#

class ImageSerializer < ActiveModel::Serializer
	attributes :data_part_id, :url, :user_id, :category_id,
	:report_id, :detail_id

	def url
		object.image.url
	end
end
