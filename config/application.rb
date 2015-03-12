require File.expand_path('../boot', __FILE__)

require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'

Bundler.require(*Rails.groups)

module Top
  class Application < Rails::Application
    config.paths.add 'lib', eager_load: true

    config.time_zone = 'Moscow'

    config.active_record.raise_in_transactional_callbacks = true
  end
end
