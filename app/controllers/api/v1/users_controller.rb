class Api::V1::UsersController < ApplicationController

  before_action :doorkeeper_authorize!, except: [ :reset_password_token ]

  def reset_password_token
    email = params.require(:email)
    user = User.find_by_email(email)
    if user
      user.send_reset_password_instructions
    end
    render nothing: true, status: :no_content
  end

  def update
    user = User.find(params[:id])
    user.update_attributes(params.require(:user))
    resource = JSONAPI::ResourceSerializer
      .new(Api::V1::UserResource)
      .serialize_to_hash(Api::V1::UserResource.new(user, nil))
    render json: resource, status: :ok
  end

  def user_params
    
end
