directory '/var/www/top/current'
rackup '/var/www/top/current/config.ru'
environment 'production'

daemonize true
pidfile '/var/www/top/shared/tmp/pids/puma.pid'
state_path '/var/www/top/shared/tmp/sockets/puma.state'
stdout_redirect '/var/www/top/shared/log/puma_error.log', '/var/www/top/shared/log/puma_access.log', true

threads 4,4

bind 'tcp://127.0.0.1:3000'
workers 1

activate_control_app 'unix:/var/www/top/shared/tmp/sockets/pumactl.sock'

preload_app!

on_restart do
  ENV["BUNDLE_GEMFILE"] = '/var/www/top/current/Gemfile'
end

on_worker_boot do
  ActiveSupport.on_load :active_record do
    ActiveRecord::Base.establish_connection
  end
end
