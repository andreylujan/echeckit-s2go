# -*- encoding : utf-8 -*-
class BaseResource < JSONAPI::Resource
  def custom_links(options)
    {self: nil}
  end

  def self.apply_filter(records, filter, value, options)
    strategy = _allowed_filters.fetch(filter.to_sym, Hash.new)[:apply]
    column = _model_class.column_for_attribute(filter)

    if column.present?
      if column.type == :text
        if value.is_a?(Array)
          value.each do |val|
            records = records.where("#{filter} ILIKE '%#{val}%'")
          end
        end
      else
        records = super(records, filter, value)
      end
    else
      if strategy
        if strategy.is_a?(Symbol) || strategy.is_a?(String)
          records = send(strategy, records, value, options)
        else
          records = strategy.call(records, value, options)
        end
      else
        records.where(filter => value)
      end
    end
    records
  end

end
