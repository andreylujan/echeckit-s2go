class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: {
      errors: [
        {
          status: '404',
          title: 'No encontrado',
          detail: 'El objeto solicitado no ha sido encontrado'
        }
      ]
    }, status: :not_found
  end

  rescue_from ActionController::ParameterMissing do |exception|
    render json: {
      errors: [
        {
          status: '400',
          detail: exception.message
        }
      ]
    }
  end

  def unauthorized_error
    { errors: [ { status: '401', detail: 'Usuario no autorizado' } ]}
  end
  def doorkeeper_unauthorized_render_options(error: nil)
    { json: unauthorized_error }
  end

  protected
  def response_from_token(token)
    response = Doorkeeper::OAuth::TokenResponse.new(token)
    body = {
      data: {
        type: 'access_tokens',
        attributes: response.body,
        relationships: {
          user: {
            data: {

            }
          }
        }
      }
    }

    if response.status == :ok
      # User the resource_owner_id from token to identify the user
      user = @user || User.find(response.token.resource_owner_id) rescue nil

      unless user.nil?
        ### If you want to render user with template
        ### create an ActionController to render out the user
        # ac = ActionController::Base.new()
        # user_json = ac.render_to_string( template: 'api/users/me', locals: { user: user})
        # body[:user] = Oj.load(user_json)

        ### Or if you want to just append user using 'as_json'
        body[:data][:relationships][:user][:data] = user.as_json

        body[:data][:server_config] = {
          store_timeout: (Time.now.to_f * 1000).to_i + 1800*1000,
          token_duration: 1800*1000
        }
      end
    end
    body
  end

end
