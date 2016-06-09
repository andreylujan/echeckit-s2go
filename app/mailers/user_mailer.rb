# -*- encoding : utf-8 -*-
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

	def checkin_email(checkin)
		@checkin = checkin
		mail(to: @checkin.user.email, subject: 'Confirmación de Llegada')
	end

	def checkout_email(checkin)
		@checkin = checkin
		mail(to: @checkin.user.email, subject: 'Confirmación de Salida')
	end
end
