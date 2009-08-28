# Application name
set :application, "rr"

# Specify Git Repository
set :scm, :git
set :repository,  "git@github.com:railsrumble/rr09-team-224.git"

# Using Git submodules for Rails plugins
set :git_enable_submodules, true

# Keep a copy of the code at the server at shared/cached-copy to allow faster pull
set :deploy_via, :remote_cache

# Set the Git branch to deploy from
set :branch , "railsrumble09"

# Set the deploy path on the server
set :deploy_to, "/home/deployer/apps/#{application}"

# Set the deploy user on the server
set :user, 'deployer'

# No need to use sudo for deployment
set :use_sudo, false

# Set the path to rake on the server (I installed RubyGems using apt-get)
set :rake, '/usr/local/bin/rake'

# Set Capistrano roles
role :app, "69.164.192.64"
role :web, "69.164.192.64"
role :db,  "69.164.192.64", :primary => true

# Set path to local deploy key
ssh_options[:keys] = ["#{ENV['HOME']}/.ssh/AynAssociates/pullfolio/id_rsa"]

# Forward my SSH key so the server can git clone/pull from the Git repository
ssh_options[:forward_agent] = true

# Custom deploy tasks
namespace :deploy do
  after "deploy:update_code", "deploy:copy_production_configurations"

  configurations_path = " #{shared_path}/config"

  desc "Copy production configuration files stored on the same remote server"
  task :copy_production_configurations, :roles => :app do
    run "cp -r #{configurations_path}/* #{release_path}/config/"
  end
  
  desc "We are using Passenger and this is how to restart the application with Passenger"
  task :restart, :roles => :app do
    run "touch /home/deployer/apps/#{application}/current/tmp/restart.txt"
  end
  
  task :start, :roles => :app do
    # Nothing
  end
end