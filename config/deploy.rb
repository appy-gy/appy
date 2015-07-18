require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/npm'
require 'mina/puma'

set :domain, '46.101.238.69'
set :deploy_to, '/var/www/top'
set :repository, 'git@github.com:kotovsky/top.git'
set :branch, 'master'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, %w{.env config/puma.rb config/secrets.yml log tmp/pids tmp/sockets}

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
    in_directory "#{deploy_to}/#{current_path}" do
      queue! %{node_modules/.bin/webpack}
    end
  end
end

namespace :prerender do
  desc 'Start prerender'
  task start: :environment do
    queue %{echo "-----> Starting prerender service"}
    in_directory "#{deploy_to}/#{current_path}" do
      queue! %{node_modules/.bin/forever start -a -l #{deploy_to}/#{current_path}/log/prerender_forever.log -o #{deploy_to}/#{current_path}/log/prerender_out.log -e #{deploy_to}/#{current_path}/log/prerender_err.log -c node_modules/.bin/coffee --uid prerender prerender/app.coffee}
    end
  end

  desc 'Restart prerender'
  task restart: :environment do
    queue %{echo "-----> Restarting prerender service"}
    in_directory "#{deploy_to}/#{current_path}" do
      queue! %{node_modules/.bin/forever restart prerender}
    end
  end

  desc 'Stop prerender'
  task stop: :environment do
    queue %{echo "-----> Stopping prerender service"}
    in_directory "#{deploy_to}/#{current_path}" do
      queue! %{node_modules/.bin/forever stop prerender}
    end
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
    invoke :'webpack:compile'
    invoke :'deploy:cleanup'

    to :launch do
      invoke :'puma:phased_restart'
      invoke :'prerender:restart'
    end
  end
end
