Rails.application.routes.draw do


  resources :organizations, except: [:new, :edit]
  resources :regions, except: [:new, :edit]
  use_doorkeeper do
    skip_controllers :sessions, :authorizations, :applications,
    :authorized_applications, :token_info
    controllers :tokens => 'tokens'
  end
  namespace :api do
    namespace :v1 do

      jsonapi_resources :zones do
        jsonapi_relationships
      end
      jsonapi_resources :regions, only: :index do
        jsonapi_relationships
      end
      jsonapi_resources :stores, only: :index do
        jsonapi_relationships
      end
      jsonapi_resources :dealers, only: :index do
        jsonapi_relationships
      end

      jsonapi_resources :organizations

      resources :users, only: [
        :create,
        :update,
        :show,
        :index
      ] do
        collection do 
          post :reset_password_token          
        end
        member do
          put :password
        end
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
