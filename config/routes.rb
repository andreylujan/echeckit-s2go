Rails.application.routes.draw do
  resources :stores
  resources :dealers
  resources :zones
  use_doorkeeper do
  	skip_controllers :sessions, :authorizations, :applications,
  	:authorized_applications, :token_info
  	controllers :tokens => 'tokens'
  end
  namespace :api do
	  namespace :v1 do
	  	resources :users, only: [
	  		:create,
	  		:update,
	  		:show,
	  		:index
	  	]
	  end
	end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
