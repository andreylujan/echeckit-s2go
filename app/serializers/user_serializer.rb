# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  rut                    :text
#  first_name             :text
#  last_name              :text
#  phone_number           :text
#  address                :text
#  picture                :text
#  role_id                :integer          not null
#

class UserSerializer < ActiveModel::Serializer
  attributes :email, :first_name, :last_name, :full_name, 
    :rut, :address, :picture, :role_name, :role_id,
    :organization_name

    def role_name
    	object.role.name
    end

    def organization_name
    	object.role.organization.name
    end
end
