class UserMailer < ApplicationMailer

	default from: 'e-Retail Admin<solutions@ewin.cl>'

	def invite_email(invitation)
		@invitation = invitation
		mail(to: @invitation.email, subject: 'Únete a e-Retail')
	end	

	def confirmation_email(user)
		@user = user
		mail(to: @user.email, subject: 'Bienvenido a e-Retail')
	end

	def reset_password_email(user)
		@user = user
		mail(to: @user.email, subject: 'Recuperación de contraseña')
	end
end