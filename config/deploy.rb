require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/npm'
require 'mina/puma'

set :domain, 'appy.gy'
set :deploy_to, '/var/www/top'
set :repository, 'git@github.com:appy-gy/appy.git'
set :branch, 'master'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, %w{.env api/deps config/puma.rb
  config/secrets.yml log public/system tmp/pids tmp/sockets} #api/config/prod.secret.exs

# Optional settings:
set :user, 'top' # Username in the server to SSH to.
set :forward_agent, true # SSH forward_agent.

set :npm_options, ''

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
    queue! %{NODE_ENV=production pm2 start prerender/server.coffee -i 1 -n prerender -l log/prerender.log --interpreter node_modules/.bin/coffee}
  end

  desc 'Restart prerender'
  task restart: :environment do
    queue %{echo "-----> Restarting prerender service"}
    queue! %{pm2 startOrRestart prerender}
  end

  desc 'Stop prerender'
  task stop: :environment do
    queue %{echo "-----> Stopping prerender service"}
    queue! %{pm2 stop prerender}
  end

  desc 'Kill prerender'
  task kill: :environment do
    queue %{echo "-----> Killing prerender service"}
    queue! %{pm2 kill}
  end
end

namespace :memcached do
  desc 'Flush memcached'
  task flush: :environment do
    queue! %{echo 'flush_all' | nc localhost 11211}
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
    invoke :'npm:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'webpack:compile'
    invoke :'deploy:cleanup'
    invoke :'memcached:flush'

    to :launch do
      invoke :'prerender:kill'
      invoke :'prerender:start'
      invoke :'puma:restart'
    end
  end
end
