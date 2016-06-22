# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'cloud_monitor'
set :repo_url, 'git@github.com:galulex/monitor_app.git'

set :deploy_to, '/home/ubuntu/cloud_monitor'

set :linked_dirs, fetch(:linked_dirs, []).push(
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'vendor/bundle',
  'public/system'
)

namespace :stream do
  desc 'Restart monitor stream'
  task :restart do
    on roles :app do
      execute "ruby #{current_path}/lib/monitor_control.rb restart"
    end
  end
end
