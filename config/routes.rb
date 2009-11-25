ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users do |user|
    user.resources :groups, :controller => 'user_groups', :member => {:follow => :get, :unfollow => :get}
  end

  map.resources :groups do |group|
    group.resources :users, :controller => 'group_users'
  end

  map.resource :session
  map.root :controller => 'welcome'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
