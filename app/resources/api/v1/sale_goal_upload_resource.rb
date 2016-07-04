class Api::V1::SaleGoalUploadResource < BaseResource
	attributes :result_csv, :uploaded_csv, :created_at, :goal_date

	def result_csv
		@model.result_csv.url
	end

	def uploaded_csv
		@model.uploaded_csv.url
	end

	def self.records(options = {})
		context = options[:context]
		records = SaleGoalUpload.all
		if context[:year]
			records = records.where('extract(year from goal_date) = ?', context[:year])
		end
		if context[:month]
			records = records.where('extract(month from goal_date) = ?', context[:month])
		end			  
		records
	end
end
