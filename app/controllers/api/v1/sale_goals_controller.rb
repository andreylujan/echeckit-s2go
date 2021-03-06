# -*- encoding : utf-8 -*-
class Api::V1::SaleGoalsController < ApplicationController

  before_action :doorkeeper_authorize!

  def csv
    begin
      csv_file = params.require(:csv)
      csv_data = CsvUtils.load_from_file(csv_file)
      if csv_data.nil?
        render json: {
          errors: [{
                     title: "Archivo inválido",
                     detail: "El archivo CSV no tiene un formato CSV válido"
                   }
                   ]
        }, status: :unprocessable_entity
        return
      end
      month = params.require(:month)
      year = params.require(:year)
      if csv_data.length > 0
        if csv_data[0].length != 2
          render json: {
            errors: [{
                       title: "Archivo inválido",
                       detail: "El archivo CSV no tiene el número de columnas esperado. Asegúrese de que el separador sea el caracter ';'"
                     }
                     ]
          }, status: :unprocessable_entity
          return
        end
      end
      csv_data.shift
      errors = []
      date = DateTime.new(year.to_i, month.to_i)
      sale_goal_upload = SaleGoalUpload.new uploaded_csv: csv_file, goal_date: date, user: current_user
      Tempfile.open(['result', '.csv']) do |fh|
        result_csv = CSV.new(fh)
        headers = [ 'Resultado', 'Código de tienda', 'Meta mensual' ]
        result_csv << headers
        num_total = 0
        num_errors = 0
        csv_data.each_with_index do |goal_row, index|

          store_code = goal_row[0].strip if goal_row[0]
          monthly_goal = goal_row[1].strip.gsub(/[\$]|[\.]/, '').to_i if goal_row[1]

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

          store = Store.where("lower(code) = ?", store_code.to_s.downcase).first
          result = "Éxito"
          if store.nil?
            data[:meta][:success] = false
            data[:meta][:errors] = {
              store_code: [ "Tienda con código indicado no existe" ]
            }
            result = "Tienda con código indicado no existe"
            num_errors += 1
          else
            goal = SaleGoal.find_or_initialize_by(store: store,
                                                  goal_date: date)
            goal.monthly_goal = monthly_goal
            goal.save
            if goal.errors.any?
              data[:meta][:success] = false
              data[:meta][:errors] = goal.errors.as_json
              result = goal.errors.full_messages.join(", ")
              num_errors += 1
            else
              data[:meta][:success] = true
            end

          end
          num_total += 1
          errors << data
          result_csv << [ result, store_code, monthly_goal ]
        end
        result_csv.close
        sale_goal_upload.result_csv = fh.open
        sale_goal_upload.num_total = num_total
        sale_goal_upload.num_errors = num_errors
        sale_goal_upload.save!
        fh.close
        fh.unlink
      end
      render json: {
        data: errors
      }, status: :ok
      return
    rescue => exception
      render json: {
        errors: [{
                   title: exception.message,
                   detail: exception.message
                 }
                 ]
      }, status: :unprocessable_entity
    end
  end

end
