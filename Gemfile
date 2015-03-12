source 'https://rubygems.org'

gem 'rails', '4.2.0'

# Server
gem 'puma'

# Database
gem 'pg'
gem 'dalli'

# Configuration
gem 'dotenv-rails'

# Serialization
gem 'active_model_serializers', github: 'rails-api/active_model_serializers', branch: '0-8-stable'
gem 'oj'
gem 'oj_mimic_json'

# Ruby extensions
gem 'handy_const'

# Authentication
gem 'sorcery'

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
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end
