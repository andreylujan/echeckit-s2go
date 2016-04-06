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
#  organization_id        :integer          not null
#  role_id                :integer          not null
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :validatable

  validates :email, uniqueness: true, presence: true
  validates :rut, uniqueness: true, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, uniqueness: true, allow_nil: true
  belongs_to :organization
  belongs_to :role
  
  def send_reset_password_instructions
    token = set_reset_password_token
    file = Tempfile.new('reset_password')
    file.write("Subject: 'Solicitud para reestablecer tu contraseña de eCheckit'\n")
    file.write("From: Solutions2Go<s2go@echeckit.cl>\n")
    file.write("To: #{full_name}<#{email}>\n")
    file.write("Hola #{full_name}!\n\n")
    file.write("Has solicitado reestablecer tu contraseña.\n\n")
    file.write("Para realizar la operacion introduce el siguente código en la aplicación: #{token}\n\n\n")
    file.write("Si no has solicitado reestablecer tu contraseña, por favor ignora este email")
    file.close
    system "sendmail -t -f #{email} -v -i < #{file.path}"
    file.unlink
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def set_reset_password_token
    token = ""
    4.times do |i|
      token = token + rand(10).to_s
    end
    self.reset_password_token = token
    self.reset_password_sent_at = Time.now.utc
    self.save validate: false
    token
  end
end
