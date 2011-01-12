set :application, 'emote_ror'
set :repository,  "git@github.com:inspirationengine/emote_ror.git"

set :scm, :git
set :branch, "master"
set :deploy_via, :checkout
set :git_shallow_clone, 1
default_run_options[:pty] = true
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "portal.emotethis.com"                          # Your HTTP server, Apache/etc
role :app, "portal.emotethis.com"                          # This may be the same as your `Web` server
role :db,  "portal.emotethis.com", :primary => true # This is where Rails migrations will run

set :deploy_to, "/var/www/apps/#{application}"
set :user, "root"
set :password, "HalretivEber"
set :group, "root"

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
                              :fix_release_dir_permission
                              
end

task :symlink_config_files do
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml"
  run "ln -s #{deploy_to}/#{shared_dir}/thumbnails #{release_path}/public/thumbnails"
  #run "ln -s #{deploy_to}/#{shared_dir}/job_logs #{release_path}/public/job_logs"
  sudo "chmod -R a+rw #{release_path}/public/thumbnails"
end

task :fix_release_dir_permission do
  run "chown -R www:www #{release_path}"
  run "chmod -R g+w #{release_path}/public"
end

task :fix_public_dir_permission do
  run "chmod -R g+w #{release_path}/public"
end


task :fix_tmp_dir_permission do
  run "chmod -R a+rw #{release_path}/tmp"
end