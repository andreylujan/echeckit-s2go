class Api::V1::UsersController < ApplicationController

  include JSONAPI::ActsAsResourceController
  before_action :doorkeeper_authorize!, except: [
    :reset_password_token,
    :index,
  :password ]

  before_action :verify_invitation, only: :create

  def reset_password_token
    email = params.require(:email)
    user = User.find_by_email(email)
    if user
      user.send_reset_password_instructions
    end
    render json: {
      data: {
        id: (DateTime.now.to_f*1000).to_i,
        type: "reset_password_tokens",
        attributes: {
          success: true
        }
      }
    }
  end


  def index
    token = params.require(:reset_password_token)
    email = params.require(:email)
    @user = User.find_by_reset_password_token_and_email(token, email)
    if @user
      render json: @user
    else
      render json: unauthorized_error, status: :unauthorized
    end
  end

  def password
    @user = User.find(params.require(:id))

    if @user.reset_password_token != params.require(:reset_password_token)
      render json: unauthorized_error, status: :unauthorized and return
    end

    if @user.update_attributes(
        password: params.require(:password),
        password_confirmation: params.require(:password_confirmation)
      )
      token = Doorkeeper::AccessToken.find_or_create_for(nil, @user.id, 'user', 7200, true)
      body = response_from_token(token)
      render json: body
    else
      render json: {
        errors: @user.errors.full_message
      }, status: :unprocessable_entity
    end
  end

  private
  def user_params
  end

  def verify_invitation
    email = params.require(:data).require(:attributes).require(:email)
    inv = Invitation.find_by_email_and_accepted(email, true)
    if inv.nil?
      render json: {
        errors: [
           {
              title: 'Invitación no fue aceptada',
              detail: 'La invitación no fue aceptada a través del link del correo'
           }
        ]
      }, status: :unauthorized
    end
  end

end
