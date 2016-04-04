class Api::V1::UsersController < ApplicationController

  before_action :doorkeeper_authorize!, except: [ 
    :reset_password_token,
    :index,
    :password ]

  def reset_password_token
    email = params.require(:email)
    user = User.find_by_email(email)
    if user
      user.send_reset_password_instructions
    end
    render nothing: true, status: :no_content
  end


  def index
    token = params.require(:reset_password_token)
    email = params.require(:email)
    @user = User.find_by_reset_password_token_and_email(token, email)
    if @user
      render json: @user
    else
      render nothing: true, status: :unauthorized
    end
  end

  def password
    @user = User.find(params.require(:id))

    if @user.reset_password_token != params.require(:reset_password_token)
      render nothing: true, status: :unauthorized and return
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

  def user_params
  end
  
end
