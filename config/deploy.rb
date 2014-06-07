require 'bundler/capistrano'
require "rvm/capistrano"
require 'capistrano/maintenance'

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

set :deploy_via, :remote_cache
set :repository,  "git@github.com:yoshikizh/swift.git"

set :scm, :git
set :scm_username,   "root"

server "115.29.105.133", :app, :web, :db, :primary => true

set :default_run_options, :pty => true

# set :ssh_options, { :forward_agent => true }
ssh_options[:paranoid] = false

set :user,       "root"

set :port, "22"
set :use_sudo, true

set :rails_env,  'production'

set :rvm_ruby_string, 'ruby-2.1.0@swift'
set :rvm_type, :system

set :bundle_without, [:development, :test]
set :normalize_asset_timestamps, false

set :default_stage, "master"

# set tag or branch or revision
# set :current_ref, `git show --format='%H' -s`.chomp
# default_ref = current_ref.chomp
# ref = Capistrano::CLI.ui.ask "Branch|Tag|Ref to deploy: [#{default_ref}] "
# ref = default_ref if ref.empty?
# set :branch, ref

set :branch, "master"
set :deploy_env, 'production'
set :application, "swift_production"
set :deploy_to,   "/var/www/swift-production"

namespace :deploy do
  task :copy_config_files, :roles => [:app] do
    db_config = "#{shared_path}/database.yml"
    run "cp #{db_config} #{release_path}/config/database.yml"
  end

  task :copy_unicorn_config_file, :roles => [:app] do
    unicorn_config = "#{shared_path}/unicorn.rb"
    run "cp #{unicorn_config} #{release_path}/config/unicorn.rb"
  end

  task :update_symlink do
    run "ln -s #{shared_path}/uploads #{release_path}/public"
  end

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "kill -USR2 `cat /var/www/swift-production/shared/pids/unicorn_production_app.pid`"
  end

  task :reload, :roles => :app, :except => { :no_release => true } do
    run "kill -HUP `cat /var/www/swift-production/shared/pids/unicorn_production_app.pid`"
  end

  task :bundle_install, :roles => :app do
    # run "cd #{release_path} && bundle install --deployment --quiet --without development test"
    run "cd #{release_path} && bundle install"
  end
end

after "deploy:update_code", "deploy:copy_config_files"
after "deploy:update_code", "deploy:copy_unicorn_config_file"
after "deploy:finalize_update", "deploy:update_symlink"


# desc "after finish deploy (synmbolic link...etc)"
# after "deploy:update_symlink", :roles => :app do
#   run "ln -s #{shared_path}/uploads #{current_path}/public/uploads"
# end

namespace :deploy do

  task :precompile do
    run "cd #{release_path}; RAILS_ENV=#{rails_env} bundle exec rake assets:precompile --trace"
  end

  # task :rvmrc_symlink do
  #   run "ln -fs #{current_path}/.rvmrc.sample #{current_path}/.rvmrc"
  # end

end


# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end