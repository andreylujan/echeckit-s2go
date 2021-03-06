# -*- encoding : utf-8 -*-
Rails.application.routes.draw do


  match '/*path', to: 'application#cors_preflight_check', via: :options
  require 'sidekiq/web'

  mount PgHero::Engine, at: "pghero"

  mount Sidekiq::Web => '/sidekiq'

  use_doorkeeper do
    skip_controllers :sessions, :authorizations, :applications,
      :authorized_applications, :token_info
    controllers :tokens => 'tokens'
  end

  namespace :api do
    namespace :v1 do

      jsonapi_resources :promotions, only: [ :show, :index, :update, :create, :destroy ] do
      end
      jsonapi_resources :zones, only: [ :index, :create, :update, :destroy, :show ] do
      end

      resources :checkins, only: [ :create ]

      resources :weekly_business_sales, only: [] do
        collection do
          post :csv
        end
      end

      post :checkouts, to: 'checkins#update'



      # jsonapi_resources :regions, only: [ :index ] do
      # end

      jsonapi_resources :tasks, only: [ :create ] do
      end

      jsonapi_resources :messages, only: [ :index, :update, :destroy ] do
        post 'read'
      end
      
      jsonapi_resources :broadcasts do
      end

      jsonapi_resources :message_actions do
      end
      
      jsonapi_resources :checklists do
      end
      
      jsonapi_resources :stock_breaks do
      end
      
      resources :products, only: [] do
        collection do
          post :csv
        end
      end

      jsonapi_resources :products do
      end

      jsonapi_resources :product_types do
      end

      jsonapi_resources :product_classifications do
      end

      jsonapi_resources :store_types do
      end

      jsonapi_resources :stock_breaks do
      end

      jsonapi_resources :devices, only: [ :create, :destroy, :update ] do
      end
      
      jsonapi_resources :stores, only: [ :index, :create, :update, :destroy, :show ] do
      end

      jsonapi_resources :dealers, only: [ :index, :create, :update, :destroy, :show ] do
      end

      jsonapi_resources :promotion_states, only: [ :index, :destroy] do
      end

      resource :dashboard, only: [] do
        get :sales
        get :metodo_prueba
        get :promoter_activity
        get :best_practices
        get :stock
        get :goals
      end

      jsonapi_resources :organizations,
      only: [ :index, :show ] do
        jsonapi_related_resources :roles, only: [ :index ]
        jsonapi_related_resources :report_types, only: [ :index ]
      end

      jsonapi_resources :reports, only: [ :create, :index, :show, :update, :destroy ]
      jsonapi_resources :roles, only: :index
      jsonapi_resources :invitations, only: [
        :create,
        :update
      ]
      
      jsonapi_resources :platforms, only: [ :index ] do
      end

      jsonapi_resources :categories, only: [ :index ] do
      end

      jsonapi_resources :principalcategories, only: [ :index ] do
      end

      jsonapi_resources :secundary_categories, only: [ :index ] do
      end
      
      resources :data_parts, only: [ :index, :show, :create, :update, :destroy ]
      resources :subsections, only: [ :index ]
      resources :images, only: [ :create, :index, :destroy ]
      resources :sections, only: [ :show, :index ]
      resources :sale_goals, only: [] do
        collection do
          post :csv
        end
      end

      jsonapi_resources :sale_goal_uploads, only: [ :index ] do
      end
      resources :promoters, only: [ :index ], to: 'users#index'
      resources :daily_reports, only: [ :index ], to: 'reports#index'
      resources :assigned_reports, only: [ :index ], to: 'reports#index'

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
          get :verify
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
