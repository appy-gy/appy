source 'https://rubygems.org'

gem 'rails', '4.2.1'

# Server
gem 'puma'

# Database
gem 'pg'
gem 'dalli'

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

# Image processing
gem 'mini_magick'

# HTTP requests
gem 'httparty'

# Procfile managment
gem 'foreman'

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
  gem 'sys-proctable', require: false
  gem 'colorize', require: false
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end
