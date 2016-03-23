source 'https://rubygems.org'


gem 'rails', '4.2.6'

gem 'rails-api'


# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18.4'
# Use Puma as the app server
gem 'puma', '~> 3.2'
gem 'pry'
gem 'dotenv-rails', '~> 2.1'

gem 'paranoia'

gem 'versionist', '~> 1.4', '>= 1.4.1'
gem 'jsonapi-resources'

# Auth
gem 'devise', '~> 3.5', '>= 3.5.6'
gem 'doorkeeper', '~> 3.1'
gem 'awesome_print', '~> 1.6', '>= 1.6.1'
gem 'jsonapi-utils'
# gem 'jbuilder', '~> 2.4', '>= 2.4.1'
# gem 'jsonapi_for_rails', '~> 0.2.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'pundit', '~> 1.1'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development do
  gem 'rails-erd', '~> 1.4', '>= 1.4.6'
  gem 'capistrano-rails', '~> 1.1', '>= 1.1.6'
  gem 'capistrano-rbenv', '~> 2.0', '>= 2.0.4'
  gem 'capistrano-passenger', '~> 0.2.0'
end

group :development, :test do
  gem 'listen', '~> 3.0', '>= 3.0.6'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.6', '>= 1.6.4'
  gem 'spring-watcher-listen', '~> 2.0'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 8.2', '>= 8.2.2'
end

group :test do
    gem 'factory_girl_rails', '~> 4.6'
    gem 'faker', '~> 1.6', '>= 1.6.3'
    # gem 'faker', '~> 1.6.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
