# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: weekly_business_sales
#
#  id              :integer          not null, primary key
#  store_id        :integer          not null
#  hardware_sales  :integer          default(0), not null
#  accessory_sales :integer          default(0), not null
#  game_sales      :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  week_start      :date
#  month           :date
#

class WeeklyBusinessSale < ActiveRecord::Base

  belongs_to :store
  validates :store, presence: true
  validates :hardware_sales, numericality: { greater_than_or_equal_to: 0, only_integer: true }, allow_nil: false
  validates :accessory_sales, numericality: { greater_than_or_equal_to: 0 }, allow_nil: false
  validates :game_sales, numericality: { greater_than_or_equal_to: 0 }, allow_nil: false
  validates :week_start, presence: true
  validates :month, presence: true

  before_save :set_default_values
  acts_as_xlsx columns: [ :id, :dealer_name, :zone_name,
                          :store_code,
                          :store_name, :month_number, :hardware_sales, :accessory_sales,
                          :game_sales,
                          :week_number,
                          :year
                          ]

  def set_default_values
    if self.hardware_sales.nil?
      self.hardware_sales = 0
    end
    if self.accessory_sales.nil?
      self.accessory_sales = 0
    end
    if self.game_sales.nil?
      self.game_sales = 0
    end
  end

  def week_number
    week_start.strftime("%U").to_i
  end

  def month_number
    month.month.to_i
  end

  def year
    month.year.to_i
  end

  def self.from_csv(csv_file, reset = false)
    begin
      header = "store_code;hardware_sales;accessory_sales;game_sales;week;month;year\n"
      sales = []
      created = []
      csv_file = csv_file.open
      lines = csv_file.readlines
      csv_file.close

      lines[0] = header

      f = Tempfile.new('csv')
      f.write lines.join
      f.close
      csv = CsvUtils.load_csv(f.path, headers=true)
      f.unlink

      if csv.nil?
        return {
          errors: [{
                     title: "Archivo inválido",
                     detail: "El archivo CSV no tiene un formato CSV válido"
                   }
                   ]
        }
      end

      if csv.headers.length != 7
        return {
          errors: [{
                     title: "Archivo inválido",
                     detail: "El archivo CSV debe tener 7 columnas (Código de tienda, ventas de hardware, " +
                     "ventas de accesorios, ventas de juego, semana (1-53), mes (1-12), año (20xx)"
                   }
                   ]
        }
      end

      WeeklyBusinessSale.transaction do
        csv.each do |row|
          begin
            store_code = row[0].strip if row[0].present?
            hardware_sales = row[1].strip.gsub(/[\$]|[\.]/, '').to_i if row[1].present?
            accessory_sales = row[2].strip.gsub(/[\$]|[\.]/, '').to_i if row[2].present?
            game_sales = row[3].strip.gsub(/[\$]|[\.]/, '').to_i if row[3].present?
            week = row[4].strip.to_i if row[4].present?
            month = row[5].strip.to_i if row[5].present?
            year = row[6].strip.to_i if row[6].present?
            store = Store.where("lowercase(code) = ?", store_code.to_s.downcase)

            has_error = false
            if store.nil?
              has_error = true
              created << ArgumentError.new("No existe una tienda con el código #{store_code}")
            end
            if not has_error
              begin
                week_start = Date.commercial(year, week)
              rescue => date_exception
                has_error = true
                created << ArgumentError.new("Semana o año inválidos")
              end
            end

            if not has_error
              begin
                month = Date.new(year, month)
              rescue => date_exception
                has_error = true
                created << ArgumentError.new("Mes o año inválidos")
              end
            end
            if not has_error
              sale = WeeklyBusinessSale.find_or_initialize_by(store: store,
                                                              week_start: week_start,
                                                              month: month)
              sale.assign_attributes hardware_sales: hardware_sales,
                accessory_sales: accessory_sales,
                game_sales: game_sales

              sale.save
              created << sale
            end
          rescue => exception
            created << exception
          end
        end
      end
      CsvUtils.generate_response(csv, created)
    rescue => exception
      return {
        errors: [
          {
            title: exception.message,
            detail: exception.message
          }
        ]
      }
    end
  end

  def dealer_criteria
    store.dealer
  end

  def zone_name
    store.zone.name
  end

  def dealer_name
    store.dealer.name
  end

  def store_name
    store.name
  end

  def store_code
    store.code
  end

  def month_criteria
    month.month
  end

  def week_criteria
    week_start.strftime("%U").to_i

  end

end
