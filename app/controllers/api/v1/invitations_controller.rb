class Api::V1::InvitationsController < ApplicationController

  before_action :doorkeeper_authorize!, only: :create
  before_action :authorize_confirmation_token!, only: :update

  include JSONAPI::ActsAsResourceController

  private
  def authorize_confirmation_token!
    token = params.require(:confirmation_token)
    invitation = Invitation.find_by_confirmation_token(token)
    if invitation.nil?
      render json: unauthorized_error, status: :unauthorized
    end
  end


end
