ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.root :controller => 'site'
  map.connect 'login', :controller => 'users', :action => 'login'
  map.connect 'logout', :controller => 'users', :action => 'logout'
  map.connect 'register', :controller => 'users', :action => 'signup'
  map.connect 'profile/:login', :controller => "users", :action => "profile"
  map.connect 'user/edit/:id', :controller => "users", :action => "edit"
  map.connect 'forgot_password', :controller => "users", :action => "forgot_password"
  map.connect 'account', :controller => "users", :action => "index"
  map.connect 'search', :controller => "search", :actin => "index"
  map.connect 'submitaphoto', :controller => "photos", :action => "new"
  map.connect 'photo/edit/:id', :controller => 'photos', :action => 'edit'
  map.connect 'photo/:id', :controller => 'photos', :action => 'show'
  map.connect 'about', :controller => 'site', :action => 'about'
  map.connect 'terms', :controller => 'site', :action => 'terms'
  map.connect 'privacy', :controller => 'site', :action => 'privacy'
  map.connect 'emailprefs', :controller => "users", :action => 'emailprefs'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect '*path', :controller => 'site', :action => 'render_404'
end
