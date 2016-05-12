require 'bundler/capistrano'
require "rvm/capistrano"
require 'capistrano_colors'
require 'capistrano/ext/multistage'
# require 'capistrano/slack'
# require 'capistrano/sidekiq'

set :default_stage, "production"

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :using_rvm, true
set :rvm_ruby_string, 'ruby-2.3.0'
set :rvm_type, :system

set :application, "id4md"
set :app_name, application
set :deploy_to, "/var/www/#{application}"
set :user,        'root'
set :use_sudo,    false

set :scm, :git
set :repository, "git@github.com:IPINVEST/pdmapp.git"
set :deploy_via, :remote_cache

set(:unicorn_conf) { "#{deploy_to}/current/config/unicorn/#{fetch(:stage)}.rb" }
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"
set :stack, :unicorn

set :sidekiq_timeout,    10
set :sidekiq_role,       :app
set :sidekiq_processes,  1

after 'deploy:finalize_update', 'deploy:run_after_finalize_update'

namespace :deploy do
  desc "Start the application"
  task :start do
    run "cd #{deploy_to}/current && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D"
  end

  desc "Stop the application"
  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end

  desc "Restart the application"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end

  desc "Copy production database configuration"
  task :run_after_finalize_update, :roles => [:app, :db, :web] do
    run "cp #{deploy_to}/shared/database.yml #{release_path}/config/database.yml"
  end

end