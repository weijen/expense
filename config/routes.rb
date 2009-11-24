ActionController::Routing::Routes.draw do |map|
  map.resources :groups

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users do |user|
    user.resources :groups, :controller => 'user_groups', :member => {:follow => :get, :unfollow => :get}
  end

  map.resource :session

  map.root :controller => 'welcome'
end
