# -*- encoding : utf-8 -*-
module CsvUtils
  require 'charlock_holmes'

  def self.load_csv(csv_path, headers=false)
    csv_file = File.open(csv_path, 'r')
    contents = csv_file.read
    detection = CharlockHolmes::EncodingDetector.detect(contents)
    if detection[:encoding].nil?
      return nil
    end
    contents.force_encoding detection[:encoding]
    contents.encode! "UTF-8"
    contents.gsub!("\r", "")
    csv = CSV.parse(contents, { headers: headers, encoding: "UTF-8", col_sep: ';'})
    csv_file.close
    csv
  end

  def self.load_from_file(csv_file, headers=false)
    contents = csv_file.read
    detection = CharlockHolmes::EncodingDetector.detect(contents)
    if detection[:encoding].nil?
      return nil
    end
    contents.force_encoding detection[:encoding]
    contents.encode! "UTF-8"
    csv = CSV.parse(contents, { headers: headers, encoding: "UTF-8", col_sep: ';' })
    csv_file.close
    csv
  end

  def self.generate_response(csv, created)
    results = []
    created.each_with_index do | val, index |
      data = {
        id: (index + 1).to_s,
        type: "csv",
        meta: {
          row_number: index + 1,
          row_data: csv[index].to_hash
        }
      }
      if not val.class < ActiveRecord::Base
        data[:meta][:success] = false
        message = val.class < Exception ? val.message : val.to_s
        data[:meta][:errors] = {
          "error de validación": [
            message
          ]
        }
      elsif val.errors.any?
        data[:meta][:success] = false
        data[:meta][:errors] = val.errors.as_json
      else
        data[:meta][:success] = true

        if val.previous_changes[:id].present? or val.previous_changes[:deleted_at].present?
          data[:meta][:created] = true
          data[:meta][:changed] = false
        elsif val.previous_changes.any?
          data[:meta][:created] = false
          data[:meta][:changed] = true
          data[:meta][:changed_attributes] =
            val.previous_changes.keys - [ "updated_at", "created_at" ]
        else
          data[:meta][:created] = false
          data[:meta][:changed] = false
        end
      end
      results << data
    end
    json = {
      data: results
    }
  end
end
