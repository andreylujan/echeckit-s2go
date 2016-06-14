source 'https://rubygems.org'

gem 'rails', '4.2.6'
gem 'rails-api', '~> 0.4.0'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18.4'

# Use Puma as the app server
gem 'puma', '~> 3.2'
gem 'pry', '~> 0.10.3'
gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'
gem 'activerecord-postgis-adapter', '~> 3.1', '>= 3.1.4'

gem 'paranoia', '~> 2.1', '>= 2.1.5'
gem 'carrierwave', '~> 0.11.0'
gem 'carrierwave-base64', '~> 2.2'
gem 'versionist', '~> 1.5'
gem 'jsonapi-resources', git: 'https://github.com/cerebris/jsonapi-resources'

gem 'ancestry', git: 'https://github.com/stefankroes/ancestry', branch: 'master'
gem 'fog', '~> 1.38'
gem 'faraday', '~> 0.9.2'
gem 'sidekiq', '~> 4.1', '>= 4.1.2'
gem 'redis', '~> 3.3'
gem 'wicked_pdf', '~> 1.0', '>= 1.0.6'
gem 'wkhtmltopdf-binary', '~> 0.9.9.3'
gem 'sinatra'
gem 'amoeba', '~> 3.0'

# Auth
gem 'devise', '~> 4.1'
gem 'doorkeeper', '~> 3.1'
gem 'awesome_print', '~> 1.6', '>= 1.6.1'
gem 'jsonapi-utils', '~> 0.4.3'
gem 'jsonapi-serializers', '~> 0.11.0'
gem 'active_model_serializers', git: 'https://github.com/rails-api/active_model_serializers', branch: 'master'
gem 'rack-cors', '~> 0.4.0', :require => 'rack/cors'
gem 'acts_as_list', '~> 0.7.4'
gem 'pundit', '~> 1.1'

group :development do
  gem 'capistrano-dotenv-tasks', '~> 0.1.3', require: false
  gem 'capistrano-rails', '~> 1.1', '>= 1.1.6'
  gem 'capistrano-rbenv', '~> 2.0', '>= 2.0.4'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'capistrano-sidekiq', '~> 0.5.4'
  gem 'rails-erd', '~> 1.4', '>= 1.4.7', require: false
  gem 'annotate', git: 'https://github.com/ctran/annotate_models.git', branch: 'develop'
  gem 'seed_dump', '~> 3.2', '>= 3.2.4', require: false
  gem 'whenever', '~> 0.9.4', require: false
end

group :development, :test do
  gem 'listen', '~> 3.0', '>= 3.0.6'
  gem 'spring', '~> 1.6', '>= 1.6.4'
  gem 'spring-watcher-listen', '~> 2.0'
  gem 'byebug', '~> 8.2', '>= 8.2.2'
  gem 'rspec-rails', '~> 3.5.0.beta3'
end

group :test do
  gem 'factory_girl_rails', '~> 4.6'
  gem 'faker', '~> 1.6', '>= 1.6.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
