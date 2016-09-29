# -*- encoding : utf-8 -*-
f = File.open('./db/promoters.csv')
csv = CSV.parse(f, { col_sep: ',' })

no_stores = []
no_users = []
loaded_stores = []
new_stores = []

csv.shift
csv.each_with_index do |row, index|

  store_code = row[2].strip if row[2].present?
  store_name = row[3].strip if row[3].present?
  supervisor_email = row[4].strip if row[4].present?
  instructor_email = row[5].strip if row[5].present?
  promoter_email = row[6].strip if row[6].present?
  part_time_email = row[7].strip if row[7].present?

  if store_code.present?

    store = Store.where("lower(code) = ?", store_code.downcase).first
    if store.present?
      if supervisor_email.present? and supervisor_email != "SIN COBERTURA"
        user = User.where("lower(email) = ?", supervisor_email.downcase).first
        if user.present?
          store.update_attribute :supervisor, user
        else
          no_users << "#{store_code} - #{supervisor_email}"
          store.update_attribute :supervisor, nil
        end
      else
        store.update_attribute :supervisor, nil
      end

      if instructor_email.present? and instructor_email != "SIN COBERTURA"
        user = User.where("lower(email) = ?", instructor_email.downcase).first
        if user.present?
          store.update_attribute :instructor, user
        else
          no_users << "#{store_code} - #{instructor_email}"
          store.update_attribute :instructor, nil
        end
      else
        store.update_attribute :instructor, nil
      end

      store.promoters = []

      if promoter_email.present? and promoter_email != "SIN COBERTURA"
        user = User.where("lower(email) = ?", promoter_email.downcase).first
        if user.present?
          store.promoters << user
        else
          no_users << "#{store_code} - #{promoter_email}"
        end
      end

      if part_time_email.present? and part_time_email != "SIN COBERTURA"
        user = User.where("lower(email) = ?", part_time_email.downcase).first
        if user.present?
          store.promoters << user
        else
          no_users << "#{store_code} - #{part_time_email}"
        end
      end
    else
      no_stores << "Fila #{index + 3} #{store_name} - #{store_code}"
    end
  end
end

puts new_stores.join("\n")
puts("-----------------------------------\n")
puts no_stores.join("\n")
puts("-----------------------------------\n")
puts no_users.join("\n")
