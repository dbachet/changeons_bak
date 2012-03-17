# -*- encoding : utf-8 -*-
default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :repository, "git@github.com:dbachet/changeons.git"  # Your clone URL
set :scm, "git"
set :user, "dagidaf"  # The server's user for deploys
set :scm_passphrase, "jaibienmangecesoir"  # The deploy user's password

ssh_options[:forward_agent] = true

set :branch, "master"

set :scm_verbose, true

set :deploy_via, :remote_cache

#http://grigio.org/deploy_rails_3_passenger_apache_dreamhost
set :application, "changeons"
# set :repository,  "git@github.com:dbachet/mariage_quetigny.git"
set :domain, "changeons.org"
#set :shared_path, "/home/#{user}/.gems"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# set :user, 'dagidaf'
set :deploy_to, "/home/#{user}/#{domain}/#{application}"
set :deploy_via, :export
set :rails_env, "production"

set :use_sudo, false
#before "deploy", "deploy:check_revision"

#after "deploy:update_code", "deploy:write_revision"
#before "deploy:gems", "deploy:symlink"

#role :web, "changeons.org"                          # Your HTTP server, Apache/etc
#role :app, "changeons.org"                          # This may be the same as your `Web` server
#role :db,  "changeons.org", :primary => true # This is where Rails migrations will run
server "changeons.org", :app, :web, :db, :primary => true

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

#after "deploy", "deploy:bundle_gems"
#after "deploy:bundle_gems", "deploy:restart"

# namespace :deploy do
##   task :bundle_gems do 
##     run "cd #{deploy_to}/current && bundle install vendor/gems
##   end
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
 
namespace :deploy do

#  desc "expand the gems"
#  task :gems, :roles => :web, :except => { :no_release => true } do
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
#    run "cd #{current_path}; #{shared_path}/bin/bundle unlock"
#    run "cd #{current_path}; nice -19 #{shared_path}/bin/bundle install vendor/" # nice -19 is very important otherwise DH will kill the process!
#    run "cd #{current_path}; #{shared_path}/bin/bundle lock"
    
  end

end
