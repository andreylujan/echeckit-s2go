# -*- encoding : utf-8 -*-
class Api::V1::StockChartController < ApplicationController

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
        if csv_data[0].length != 8
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
      Rails.logger.info "dateeeee: #{date}"
      stock_chart_upload = StockChartUpload.new uploaded_csv: csv_file, stock_date: date, user: current_user
      Tempfile.open(['result', '.csv']) do |fh|
        result_csv = CSV.new(fh)
        headers = [ 'DEALER', 'CATEGORÍA', 'CODIGO TIENDA', 'TIENDA', 'SEMANA', 'AÑO', 'MES', 'STOCK EN UNIDADES' ]
        result_csv << headers
        num_total = 0
        num_errors = 0
        csv_data.each_with_index do |stock_row, index|

          dealer = stock_row[0].strip if stock_row[0]
          category_stock = stock_row[1].strip if stock_row[1]
          store_code = stock_row[2].strip if stock_row[2]
          store_name = stock_row[3].strip if stock_row[3]
          week = stock_row[4].strip if stock_row[4]
          year = stock_row[5].strip if stock_row[5]
          month = stock_row[6].strip if stock_row[6]
          unit_stock = stock_row[7].strip if stock_row[7]

          data = {
            id: (index + 1).to_s,
            type: "csv",
            meta: {
              row_number: index + 1,
              row_data: {
                dealer: dealer,
                category_stock: category_stock,
                store_code: store_code,
                store_name: store_name,
                week: week,
                year: year,
                month: month,
                unit_stock: unit_stock           
              }
            }
          }

          store = Store.where("lower(code) = ?", store_code.to_s.downcase).first
          Rails.logger.info "store: #{store}"
          result = "Éxito"
          if store.nil?
            data[:meta][:success] = false
            data[:meta][:errors] = {
              store_code: [ "Tienda con código indicado no existe" ]
            }
            result = "Tienda con código indicado no existe"
            num_errors += 1
          else
            stock = StockChart.find_or_initialize_by(store: store,
                                                  stock_date: date)
            stock.stock_category = category_stock
            stock.store_code = store_code
            stock.store_name = store_name
            stock.week = week
            stock.year = year
            stock.month = month
            stock.unit_stock = unit_stock
            stock.dealer = dealer
            stock.save
            Rails.logger.info "******* stock.saveeee"
            if stock.errors.any?
              data[:meta][:success] = false
              data[:meta][:errors] = stock.errors.as_json
              result = stock.errors.full_messages.join(", ")
              num_errors += 1
            else
              data[:meta][:success] = true
            end

          end
          num_total += 1
          errors << data
          result_csv << [ result, store_code, month ]
        end
        result_csv.close
        stock_chart_upload.result_csv = fh.open
        stock_chart_upload.num_total = num_total
        stock_chart_upload.num_errors = num_errors
        stock_chart_upload.save!
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
