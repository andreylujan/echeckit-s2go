source 'https://rubygems.org'


gem 'rails', '4.2.6'

gem 'rails-api'


# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18.4'
gem 'rake', '~> 11.1', '>= 11.1.2'

# Use Puma as the app server
gem 'puma', '~> 3.2'
gem 'pry'
gem 'dotenv-rails', '~> 2.1'
gem 'activerecord-postgis-adapter', '~> 3.1', '>= 3.1.4'

gem 'paranoia'
gem 'aws-sdk', '~> 2.2', '>= 2.2.34'
gem 'carrierwave-base64', '~> 2.1', '>= 2.1.1'
gem 'versionist', '~> 1.4', '>= 1.4.1'
gem 'jsonapi-resources'
gem 'ancestry', git: 'https://github.com/stefankroes/ancestry', branch: 'master'
# Auth
gem 'devise', '~> 3.5', '>= 3.5.6'
gem 'doorkeeper', '~> 3.1'
gem 'awesome_print', '~> 1.6', '>= 1.6.1'
gem 'jsonapi-utils'
gem 'jsonapi-serializers'
gem 'active_model_serializers', git: 'https://github.com/rails-api/active_model_serializers', branch: 'master'
gem 'rack-cors', :require => 'rack/cors'
gem 'acts_as_list', '~> 0.7.4'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
gem 'pundit', '~> 1.1'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
# gem 'responders', '~> 2.1', '>= 2.1.2'

group :development do
  gem 'capistrano-rails', '~> 1.1', '>= 1.1.6'
  gem 'capistrano-rbenv', '~> 2.0', '>= 2.0.4'
  gem 'capistrano-passenger', '~> 0.2.0'
  gem 'rails-erd', '~> 1.4', '>= 1.4.6', require: false
  gem 'annotate', git: 'https://github.com/ctran/annotate_models.git', branch: 'develop'
  gem 'seed_dump', require: false
  gem 'whenever', require: false
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
