ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'
require File.expand_path '../../config/environment', __FILE__
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

DatabaseCleaner.strategy = :transaction

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.disable_monkey_patching!

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.profile_examples = 10

  config.order = :random

  config.before :all do
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end

  config.after :all do
    FakeModelFactory.cleanup
  end

  config.before do
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end

  config.before do
    Rails.cache.clear
  end
end
