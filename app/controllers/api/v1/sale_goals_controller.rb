class Api::V1::SaleGoalsController < ApplicationController

	before_action :doorkeeper_authorize!

	def csv
		csv_file = params.require(:csv)
		csv_data = CsvUtils.load_from_file(csv_file)
		month = params.require(:month)
		year = params.require(:year)
		csv_data.shift
		errors = []
		date = DateTime.new(year.to_i, month.to_i)
		csv_data.each_with_index do |goal_row, index|

			store_code = goal_row[0]
			monthly_goal = goal_row[1]

			data = {
				id: (index + 1).to_s,
				type: "csv",
				meta: {
					row_number: index + 1,
					row_data: {
						store_code: store_code,
						monthly_goal: monthly_goal
					}
				}				
			}
			
			store = Store.find_by_code(store_code)
			if store.nil?
				data[:meta][:success] = false
				data[:meta][:errors] = {
					store_code: [ "Tienda con código indicado no existe" ]
				}
			else
				goal = SaleGoal.find_or_initialize_by(store: store, 
					goal_date: date)
				goal.monthly_goal = monthly_goal
				goal.save
				if goal.errors.any?
					data[:meta][:success] = false
					data[:meta][:errors] = goal.errors.as_json
				else
					data[:meta][:success] = true
				end
				
			end
			errors << data
		end
		render json: {
			data: errors
		}
	end

end
