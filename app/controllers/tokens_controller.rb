class TokensController < Doorkeeper::TokensController

  # Overriding create action
  # POST /oauth/token
  def create
    response = authorize_response
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
      user = User.find(response.token.resource_owner_id) rescue nil

      unless user.nil?
        ### If you want to render user with template
        ### create an ActionController to render out the user
        # ac = ActionController::Base.new()
        # user_json = ac.render_to_string( template: 'api/users/me', locals: { user: user})
        # body[:user] = Oj.load(user_json)

        ### Or if you want to just append user using 'as_json'
        body[:data][:relationships][:user][:data] = UserSerializer.new(user).as_json

        body[:data][:server_config] = {
          store_timeout: (Time.now.to_f * 1000).to_i + 1800*1000,
          token_duration: 1800*1000
        }
      end
    end


    self.headers.merge! response.headers
    self.response_body = body.to_json
    self.status        = response.status


  rescue Doorkeeper::Errors::DoorkeeperError => e
    handle_token_exception e
  end

end
