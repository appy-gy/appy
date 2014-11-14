require File.expand_path('../boot', __FILE__)

require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"

Bundler.require(*Rails.groups)

module Top
  class Application < Rails::Application
    config.autoload_paths += %W(#{config.root}/lib)

    config.time_zone = 'Moscow'

    config.active_record.raise_in_transactional_callbacks = true
    config.active_record.schema_format = :sql
  end
end
