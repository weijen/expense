ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.setting '/account/setting', :controller => 'users', :action => 'edit'

  map.resources :users do |user|
    user.resources :groups, :controller => 'user_groups', :member => {:join => :get}
  end

  map.resources :groups, :member => {:freeze => :post, :alive => :post, :freeze_date => :post, :report =>:get} do |group|
    group.resources :users, :controller => 'group_users', :member => {:approve => :get}, :collection => {:invite => :get}
    group.resources :expenses, :controller => "group_expenses", :collection => {:users_report => :get, :tabs_report => :get}
    group.resources :tags, :controller => "group_tags"
  end

  map.resources :tags

  map.resources :expenses

  map.resource :session
  
  map.resources :welcome, :collection => {:joined_groups => :get, :managed => :get, :my => :get}

  map.root :controller => 'welcome'

  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
