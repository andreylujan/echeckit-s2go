# == Schema Information
#
# Table name: invitations
#
#  id                 :integer          not null, primary key
#  role_id            :integer          not null
#  confirmation_token :text             not null
#  email              :text             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  accepted           :boolean          default(FALSE), not null
#

class Invitation < ActiveRecord::Base
  belongs_to :role

  validates_presence_of [ :role, :email ]
  validates_uniqueness_of :email

  before_create :generate_confirmation_token

  before_validation :lowercase_email
  before_validation :verify_email, on: :create
  validate :user_existence
  after_create :send_email

  def send_email
    token = confirmation_token
    file = Tempfile.new("invite_#{confirmation_token}")
    file.write("Subject: 'Invitación a eCheckit'\n")
    file.write("From: Solutions2Go<s2go@echeckit.cl>\n")
    file.write("To: #{email}<#{email}>\n")
    file.write("Para aceptar la invitación haz click en \n")
    file.write("http://localhost:8000/invitation?confirmation_token=#{confirmation_token}")
    file.close
    system "sendmail -t -f #{email} -v -i < #{file.path}"
    file.unlink
    # UserMailer.invite_email(self).deliver_now!
  end

  private

  def user_existence
    user = User.find_by_email(self.email)
    if user.present?
      errors.add(:email, "Ya existe un usuario con este correo")
    end
  end

  def lowercase_email
    self.email = self.email.downcase if self.email.present?
  end

  def verify_email
    if self.email.present?
      old_invitation = Invitation.find_by_email(self.email)
      if old_invitation
        old_invitation.destroy
      end
    end
  end

  def generate_confirmation_token
    self.confirmation_token = SecureRandom.urlsafe_base64(64)
  end

end
