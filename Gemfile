source 'https://rubygems.org'

gem 'rails', '4.2.5.1'

# Server
gem 'puma'

# Database
gem 'pg'
gem 'dalli'
gem 'redis-objects'
gem 'chewy'

# Configuration
gem 'dotenv-rails'

# Serialization
gem 'active_model_serializers', '~> 0.8.3'
gem 'oj'
gem 'oj_mimic_json'

# Ruby extensions
gem 'handy_const'

# Authentication
gem 'sorcery'

# Files upload
gem 'carrierwave'
gem 'carrierwave-processing'

# Video info
gem 'video_info'

# Pagination
gem 'kaminari'

# Soft delete
gem 'paranoia'

# Image processing
gem 'mini_magick'

# HTTP requests
gem 'httparty'

# Procfile managment
gem 'foreman'

# I18n
gem 'russian'
gem 'enum_help'

# Friendly urls
gem 'babosa'
gem 'friendly_id'

# Mailing
gem 'mandrill-api'
gem 'slim'

# Administration
gem 'activeadmin', '~> 1.0.0.pre1'

# Command line
gem 'cocaine'

# Jobs
gem 'sidekiq'
gem 'whenever', require: false

# Monitoring
gem 'newrelic_rpm'

# Assets
gem 'uglifier'

group :development, :test do
  gem 'awesome_print'
  gem 'pry-rails'
  gem 'did_you_mean'
  gem 'ruby-prof'
end

group :development do
  gem 'guard'
  gem 'guard-rspec'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'mina', require: false
  gem 'mina-puma', require: false
  gem 'mina-sidekiq', require: false
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end
