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
#  week_number     :integer          not null
#  deleted_at      :datetime
#  category,       :string           default: '' null:false
#  goals_sales     :json             default: {} null: false
#

class WeeklyBusinessSale < ActiveRecord::Base

  belongs_to :store
  validates :store, presence: true
  validates :hardware_sales, numericality: { only_integer: true }, allow_nil: true
  validates :accessory_sales, numericality: { only_integer: true }, allow_nil: true
  validates :game_sales, numericality: { only_integer: true }, allow_nil: true
  validates :month, presence: true
  validates :week_number, numericality: { only_integer: true, :greater_than_or_equal_to => 1,
    :less_than_or_equal_to => 53 }

  acts_as_paranoid

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



  def month_number
    month.month.to_i
  end

  def year
    month.year.to_i
  end

  def self.from_csv(csv_file, reset = false)
    begin
      #header = "store_code;hardware_sales;accessory_sales;game_sales;week;month;year\n"
      header ="dealer;store_code;dealer_city;goal;category;month;year;zone;sale\n"
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

      if csv.headers.length < 9
        return {
          errors: [{
                     title: "Archivo inválido",
                     detail: "El archivo CSV debe tener 9 columnas (Tienda, Código de tienda, Ciudad tienda, " +
                     "meta, Categoría, mes (1-12), año (20xx), Zona, Venta)"
                   }
                   ]
        }
      end

      WeeklyBusinessSale.transaction do
        csv.each do |row|
          begin
            #header ="dealer;store_code;dealer_city;goal;category;month;year;zone;sale\n"
            #store_code = row[0].strip if row[0].present?
            #hardware_sales = row[1].strip.gsub(/[\$]|[\.]/, '').to_i if row[1].present?
            #accessory_sales = row[2].strip.gsub(/[\$]|[\.]/, '').to_i if row[2].present?
            #game_sales = row[3].strip.gsub(/[\$]|[\.]/, '').to_i if row[3].present?
            #week = row[4].strip.to_i if row[4].present?
            #week_number = row[4].strip.to_i if row[4].present?
            #month = row[5].strip.to_i if row[5].present?
            #year = row[6].strip.to_i if row[6].present?

            store_code = row[1].strip if row[1].present?
            hardware_sales = 0
            accessory_sales = 0
            game_sales = 0
            week_number = 1
            goals = row[3].strip.gsub(/[\$]|[\.]/, '').to_i if row[3].present?
            category = row[4].strip if row[4].present?
            month = row[5].strip.to_i if row[5].present?
            year = row[6].strip.to_i if row[6].present?
            s = row[8].strip.gsub(/[\$]|[\.]/, '').to_i if row[8].present?
            store = Store.where("lower(code) = ?", store_code.to_s.downcase).first

            has_error = false
            if store.nil?
              has_error = true
              created << ArgumentError.new("No existe una tienda con el código #{store_code}")
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
                                                              week_number: week_number,
                                                              month: month)
              sale.assign_attributes hardware_sales: hardware_sales,
                accessory_sales: accessory_sales,
                game_sales: game_sales,
                category: category,
                goals_sales:{metas:goals, venta:s}

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


end
