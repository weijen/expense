ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.setting '/account/setting', :controller => 'users', :action => 'edit'

  map.resources :users do |user|
    user.resources :groups, :controller => 'user_groups', :member => {:follow => :get, :unfollow => :get}
  end

  map.resources :groups do |group|
    group.resources :users, :controller => 'group_users', :member => {:approve => :get}
    group.resources :expenses, :controller => "group_expenses"
    group.resources :tags, :controller => "group_tags"
  end

  map.resources :expenses

  map.resource :session

  map.root :controller => 'welcome'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
