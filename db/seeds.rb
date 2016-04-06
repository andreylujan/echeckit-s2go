
Organization.create!([
  {name: "Playstation"}
])
Role.create!([
  {organization_id: 1, name: "Supervisor"},
  {organization_id: 1, name: "Promotor"}
])
User.create!([
  {email: "pablo.lluch@gmail.com", encrypted_password: "$2a$10$.ipOlZxRsAoMQVo0XNb5A.yKx1t01j4xShGxMitj4arhEU.df3E/C", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, confirmation_token: nil, confirmed_at: nil, confirmation_sent_at: nil, unconfirmed_email: nil, rut: "17.085.953-7", first_name: "Pablo", last_name: "Lluch", phone_number: nil, address: nil, picture: nil, organization_id: 1, role_id: 1}
])
