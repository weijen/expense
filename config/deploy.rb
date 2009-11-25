set :application, "expense"

default_run_options[:pty] = true
set :repository,  "git@github.com:weijen/expense.git"
set :scm, "git"
set :scm_password, "james314"
set :user, "weijen"
set :runner, "weijen"
set :deploy_to, "/var/www/#{application}"

ssh_options[:forward_agent] = true
set :branch, "master"

set :deploy_via, :remote_cache

role :web, "weijen.net"
role :app, "weijen.net"
role :db, "weijen.net", :primary => true

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
      desc "#{t} task is a no-op with mod_rails"
      task t, :roles      => :app do ; end
  end
end

desc "Link in the production database.yml" 
task :after_update_code do
  run "ln -nfs #{deploy_to}/#{shared_dir}/config/database.yml #{release_path}/config/database.yml" 
end
