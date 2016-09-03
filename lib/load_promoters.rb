f = File.open('./db/promoters.csv')
csv = CSV.parse(f, { col_sep: ',' })

no_stores = []
no_users = []
loaded_stores = []
new_stores = []

csv.shift
csv.each_with_index do |row, index|
  promoter_email = row[4].strip if row[4].present?
  store_code = row[0].strip if row[0].present?

  if promoter_email.present? and store_code.present?
    user = User.where("lower(email) = ?", promoter_email.downcase).first
    store = Store.find_by_code(store_code)
    if user.present? and store.present?
      loaded_stores << store_code
      store.update_attributes! promoter: user
    else
      if not user.present?
        no_users << "Fila #{index + 4} #{row[2].strip} - #{promoter_email}"
      end

      if not store.present?
        store = Store.where('lower(name) = ?', row[1].strip.downcase).first
        if store.present?
          new_stores << store_code
          store.update_attributes! code: store_code
        else
          no_stores << "Fila #{index + 4} #{row[1].strip} - #{store_code}"
        end
      end
    end
  end
end

puts new_stores.join("\n")
puts("-----------------------------------\n")
puts no_stores.join("\n")
puts("-----------------------------------\n")
puts no_users.join("\n")
