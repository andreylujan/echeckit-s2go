class SalesReport
  include Mongoid::Document

  def self.default_sales_by_company
    {
      name: "PlayStation",
        sales_by_type: {
        hardware: 0,
        accesories: 0,
        games: 0
      }
    }
  end

  field :sales_by_company, type: Array, default: default_sales_by_company
  
  field :year, type: Integer, default: ->{ DateTime.now.year }
  field :month, type: Integer, default: ->{ DateTime.now.month }

  def self.update_report(report)

  end

  


  
end
