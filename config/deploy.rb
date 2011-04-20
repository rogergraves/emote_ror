require 'bundler/capistrano'

set :application, 'emote'
set :repository,  "git@github.com:inspirationengine/emote_ror.git"

set :scm, :git
set :deploy_via, :checkout
set :git_shallow_clone, 1
default_run_options[:pty] = true
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

task :live do
  set :branch, "release"
  role :web, "emote.inspirationengine.com"                          # Your HTTP server, Apache/etc
  role :app, "emote.inspirationengine.com"                          # This may be the same as your `Web` server
  role :db,  "emote.inspirationengine.com", :primary => true # This is where Rails migrations will run

  set :deploy_to, "/var/www/apps/#{application}"
  set :user, "root"
  set :password, "web1Bd1XKmi06"
  set :group, "root"
end

task :stage do
  set :branch, "master"
  role :web, "184.106.92.80"                          # Your HTTP server, Apache/etc
  role :app, "184.106.92.80"                          # This may be the same as your `Web` server
  role :db,  "184.106.92.80", :primary => true # This is where Rails migrations will run

  set :rails_env, "staging"
  set :deploy_to, "/var/www/apps/#{application}"
  set :user, "root"
  set :password, "stagingfm66A2KIu"
  set :group, "root"
end

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start, :roles => :app do 
    
  end
  
  task :stop, :roles => :app do
  
  end
  
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  
  after "deploy:update_code", :symlink_config_files,
                              :fix_public_dir_permission,
                              :fix_tmp_dir_permission,
                              :fix_release_dir_permission,
                              "deploy:migrate"
                              
end

task :symlink_config_files do
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"
  run "ln -s #{deploy_to}/#{shared_dir}/thumbnails #{release_path}/public/thumbnails"
  #run "ln -s #{deploy_to}/#{shared_dir}/job_logs #{release_path}/public/job_logs"
  sudo "chmod -R a+rw #{release_path}/public/thumbnails"
end

task :fix_release_dir_permission do
  run "chown -R www-data:www-data #{release_path}"
  run "chmod -R g+w #{release_path}/public"
end

task :fix_public_dir_permission do
  run "chmod -R g+w #{release_path}/public"
end


task :fix_tmp_dir_permission do
  run "chmod -R a+rw #{release_path}/tmp"
end