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

  def self.from_csv(csv_file, reset = false)
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

    WeeklyBusinessSale.transaction do
      
      csv.each do |row|
        begin
          store_code = row[0].strip if row[0].present?
          hardware_sales = row[1].strip.to_i if row[1].present?
          accessory_sales = row[2].strip.to_i if row[2].present?
          game_sales = row[3].strip.to_i if row[3].present?
          week = row[4].strip.to_i if row[4].present?
          month = row[5].strip.to_i if row[5].present?
          year = row[6].strip.to_i if row[6].present?
          store = Store.find_by_code!(store_code)
          week_start = Date.commercial(year, week)
          month = Date.new(year, month)
          sale = WeeklyBusinessSale.find_or_initialize_by(store: store,
                                                            week_start: week_start,
          month: month)
          sale.assign_attributes hardware_sales: hardware_sales,
              accessory_sales: accessory_sales,
              game_sales: game_sales
          
          sale.save
          created << sale
        rescue => exception
          created << exception
        end
      end

    end
    CsvUtils.generate_response(csv, created)
  end
end
