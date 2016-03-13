source 'https://rubygems.org'

gem 'rails', '4.2.5.1'

# Server
gem 'puma', '~> 2.15.2'

# Database
gem 'pg', '~> 0.18.3'
gem 'dalli', '~> 2.7.4'
gem 'redis-objects', '~> 1.2.1'
gem 'chewy', '~> 0.8.2'

# Configuration
gem 'dotenv-rails', '~> 2.0.2'

# Serialization
gem 'active_model_serializers', '~> 0.8.3'
gem 'oj', '~> 2.13.0'
gem 'oj_mimic_json', '~> 1.0.1'

# Ruby extensions
gem 'handy_const', '~> 0.1.1'

# Authentication
gem 'sorcery', '~> 0.9.1'

# Video info
gem 'video_info', '~> 2.5.0'

# Pagination
gem 'kaminari', '~> 0.16.3'

# Soft delete
gem 'paranoia', '~> 2.1.4'

# HTTP requests
gem 'httparty', '~> 0.13.7'

# I18n
gem 'russian', '~> 0.6.0'
gem 'enum_help', '~> 0.0.14'

# Friendly urls
gem 'babosa', '~> 1.0.2'
gem 'friendly_id', '~> 5.1.0'

# Mailing
gem 'slim', '~> 3.0.6'

# Administration
gem 'activeadmin', '~> 1.0.0.pre1'

# Command line
gem 'cocaine', '~> 0.5.7'

# Jobs
gem 'sidekiq', '~> 4.1.0'
gem 'whenever', '~> 0.9.4', require: false

# Monitoring
gem 'newrelic_rpm', '~> 3.14.0.305'

# Assets
gem 'uglifier', '~> 2.7.2'

group :development, :test do
  gem 'awesome_print'
  gem 'pry-rails'
  gem 'did_you_mean'
  gem 'ruby-prof'
end

group :development do
  gem 'foreman', '~> 0.78.0', require: false
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
