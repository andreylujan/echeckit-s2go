Rails.application.routes.draw do

  match '/*path', to: 'application#cors_preflight_check', via: :options
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
      jsonapi_resources :regions do
        jsonapi_relationships
      end
      jsonapi_resources :stores do
        jsonapi_relationships
      end
      jsonapi_resources :dealers do
        jsonapi_relationships
      end

      resources :categories, only: [ :index ]
      resources :images, only: [ :create ]
      
      resources :sections
      resources :platforms, only: [ :index ]
      jsonapi_resources :organizations,
      only: [ :index, :show ] do
        jsonapi_relationships   
        jsonapi_resources :report_types   
      end

      resource :top_list, only: [ :show ]
      jsonapi_resources :reports
      
      jsonapi_resources :roles, only: :index
      jsonapi_resources :invitations, only: [
        :create,
        :update
      ]

      resources :users, only: [
        :create,
        :update,
        :show,
        :index,
        :destroy
      ] do
        collection do
          post :reset_password_token
          get :all
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
