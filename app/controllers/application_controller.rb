class ApplicationController < ActionController::API
    include JSONAPI::ActsAsResourceController
    include ::ActionController::Flash
	include ::ActionView::Layouts
	include ::ActionController::Helpers
	include ::ActionController::MimeResponds
	include ::ActionController::RequestForgeryProtection
end
