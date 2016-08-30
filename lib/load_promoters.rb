f = File.open('./db/promoters.csv')
csv = CSV.parse(f, { col_sep: ',' })

no_stores = []
no_users = []
loaded_stores = []

csv.shift
csv.each do |row|
  promoter_email = row[4].strip if row[4].present?
  dealer_name = row[5].strip if row[5].present?
  store_code = row[7].strip if row[7].present?

  if promoter_email.present?
    user = User.where("lower(email) = ?", promoter_email.downcase).first
    if user.present?
      full_code = "#{dealer_name}#{store_code}"
      store = Store.find_by_code(full_code)
      if store.present?
        loaded_stores << full_code
        store.update_attributes! promoter: user
      else
        no_stores << full_code
      end
    else
      no_users << promoter_email
    end

  end
end

ap no_stores
ap no_users
ap loaded_stores
