require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/npm'
require 'mina/puma'
require 'mina_sidekiq/tasks'

set :domain, '46.101.238.69'
set :deploy_to, '/var/www/top'
set :repository, 'git@github.com:kotovsky/top.git'
set :branch, 'master'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, %w{.env api/config/prod.secret.exs api/deps config/puma.rb
  config/secrets.yml log public/system tmp/pids tmp/sockets}

# Optional settings:
set :user, 'top' # Username in the server to SSH to.
set :forward_agent, true # SSH forward_agent.

set :npm_options, ''

set :sidekiq_pid, -> { "#{deploy_to}/#{current_path}/tmp/pids/sidekiq.pid" }

set :phoenid_pid, -> { "#{deploy_to}/#{shared_path}/tmp/pids/phoenix.pid" }

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task setup: :environment do
  in_directory "#{deploy_to}/#{shared_path}" do
    queue! %{touch .env}
    queue! %{mkdir -p log}
    queue! %{mkdir -p config}
    queue! %{touch config/puma.rb}
    queue! %{touch config/secrets.yml}
    queue! %{mkdir -p tmp/sockets}
    queue! %{mkdir -p tmp/pids}
  end
end

namespace :webpack do
  desc 'Compile assets'
  task compile: :environment do
    queue %{echo "-----> Compiling assets"}
    in_directory "#{deploy_to}/$build_path" do
      queue! %{node_modules/.bin/webpack}
    end
  end
end

namespace :prerender do
  desc 'Start prerender'
  task start: :environment do
    queue %{echo "-----> Starting prerender service"}
    queue! %{cd #{deploy_to}/#{current_path} && NODE_ENV=production node_modules/.bin/pm2 start prerender/server.coffee -i 1 -n prerender -l log/prerender.log --interpreter node_modules/.bin/coffee}
  end

  desc 'Restart prerender'
  task restart: :environment do
    queue %{echo "-----> Restarting prerender service"}
    queue! %{cd #{deploy_to}/#{current_path} && node_modules/.bin/pm2 startOrRestart prerender}
  end

  desc 'Stop prerender'
  task stop: :environment do
    queue %{echo "-----> Stopping prerender service"}
    queue! %{cd #{deploy_to}/#{current_path} && node_modules/.bin/pm2 stop prerender}
  end

  desc 'Kill prerender'
  task kill: :environment do
    queue %{echo "-----> Killing prerender service"}
    queue! %{cd #{deploy_to}/#{current_path} && node_modules/.bin/pm2 kill}
  end
end

namespace :memcached do
  desc 'Flush memcached'
  task flush: :environment do
    queue! %{echo 'flush_all' | nc localhost 11211}
  end
end

namespace :mix do
  desc 'Install mix deps'
  task get_deps: :environment do
    queue! %{cd #{deploy_to}/#{current_path}/api && mix deps.get --only prod}
  end
end

namespace :phoenix do
  desc 'Start phoenix process'
  task start: :environment do
    queue! %{cd #{deploy_to}/#{current_path}/api && MIX_ENV=prod PORT=4001 elixir --detached -S mix do compile, phoenix.server}
  end

  desc 'Kill phoenix process'
  task kill: :environment do
    queue! %{kill -9 `cat #{fetch :phoenid_pid}`}
  end
end

desc 'Deploys the current version to the server.'
task deploy: :environment do
  to :before_hook do
  end

  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'mix:get_deps'
    invoke :'npm:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'webpack:compile'
    invoke :'deploy:cleanup'
    invoke :'memcached:flush'

    to :launch do
      invoke :'sidekiq:restart'
      invoke :'phoenix:kill'
      invoke :'phoenix:start'
      invoke :'prerender:kill'
      invoke :'prerender:start'
      invoke :'puma:restart'
    end
  end
end
