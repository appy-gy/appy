require File.expand_path('../boot', __FILE__)

require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module Top
  class Application < Rails::Application
    config.paths.add 'lib', eager_load: true

    config.time_zone = 'Moscow'

    config.host = URI.parse(ENV['TOP_HOST']).host

    config.active_record.raise_in_transactional_callbacks = true

    config.action_mailer.default_url_options = { host: config.host }
    config.action_mailer.default_options = {
      from: "reply@#{config.host}"
    }

    config.i18n.load_path = Dir.glob Rails.root.join('config/locales/**/*.yml').to_s
    config.i18n.default_locale = :ru
  end
end
