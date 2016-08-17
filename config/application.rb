# -*- encoding : utf-8 -*-
require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'dotenv'


# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
Dotenv.load

module EcheckitApi
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :"es-CL"
    config.i18n.fallbacks = {:"es-CL" => :es, :es => :en}

    config.api_only = false
    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true
    config.autoload_paths += Dir[Rails.root.join('app', 'models', 'data_parts')]
    config.autoload_paths += Dir[Rails.root.join('app', 'serializers', 'data_parts')]
    config.active_job.queue_adapter = :sidekiq
    
    # config.time_zone = "Santiago"
    # config.active_record.default_timezone = "Santiago"

    ActiveModelSerializers.config.adapter = :json_api
    ActiveModelSerializers.config.key_transform = :underscore
    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options, :put, :patch, :delete]
      end
    end

    config.action_mailer.delivery_method = :smtp
    
    config.action_view.logger = nil

    config.action_mailer.smtp_settings = {
      :address        => 'smtp.office365.com',
        :port           => '587',
        :authentication => :login,
        :user_name      => ENV['TROKA_EMAIL_USERNAME'],
        :password       => ENV['TROKA_EMAIL_PASSWORD'],
        :domain         => 'ewin.cl',
        :enable_starttls_auto => true
    }

  end
end




