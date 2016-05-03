class UserMailer < ApplicationMailer

	default from: 'solutions@ewin.cl'

	def invite_email(invitation)
		@invitation = invitation
		mail(to: @invitation.email, subject: 'Bienvenido a eCheckit')
	end	

end
