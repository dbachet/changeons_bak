Changeons::Application.routes.draw do
  get "error_pages/javascript_disabled"

  resources :post_types

  # resources :types

  resources :categories
  
  match 'posts/:post_id/comments/show_guest_fields' => 'comments#show_guest_fields', :as => "show_guest_fields"
  match 'posts/:post_id/comments/:id/show_guest_fields_for_reply' => 'comments#show_guest_fields_for_reply', :as => "show_guest_fields_for_reply"
  
  # match 'posts/:post_id/comments/comment_as_guest' => 'comments#comment_as_guest', :as => 'comment_as_guest', :via => 'get'
  match 'posts/:post_id/comments/create_comment_as_guest' => 'comments#create_comment_as_guest', :as => 'create_comment_as_guest', :via => 'post'
  
  # match 'posts/:post_id/comments/:id/reply_as_guest' => 'comments#reply_as_guest', :as => 'reply_as_guest', :via => 'get'
  match 'posts/:post_id/comments/:id/create_reply_as_guest' => 'comments#create_reply_as_guest', :as => 'create_reply_as_guest', :via => 'post'
  
  post 'posts/show_more_posts', :as => 'show_more_posts'
  # post 'comments/show_more_comments', :as => 'show_more_comments'
  match 'posts/:post_id/show_more_comments' => 'comments#show_more_comments', :as => 'show_more_comments', :via => 'post'
  
  resources :posts do
    resources :comments, :except => [:index, :show, :new] do
      member do
        get :show_reply
        get :reply
        post :create_reply
      end
    end
    member do
      post :vote_up
      post :vote_down
    end
  end

  get "pages/home"

  get "pages/contact"

  get "pages/search"

  devise_for :users, :controllers => {:sessions => 'sessions'} do
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "posts#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
