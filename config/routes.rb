# -*- encoding : utf-8 -*-
Changeons::Application.routes.draw do
  match "tags/:tag_id/" => "tags#show_posts", :as => "tag_show_posts"  
  
  resources :upload_pictures
  
  match "/categories/:category_id/product_tests" => "product_tests#index", :as => "product_tests_from_category"
  get "product_tests/add_source"
  get "product_tests/remove_source"
  get "product_tests/show_advantage_form_field"
  get "product_tests/add_advantage"
  get "product_tests/remove_advantage"
  get "product_tests/show_drawback_form_field"
  get "product_tests/add_drawback"
  get "product_tests/remove_drawback"
  resources :product_tests do
    resources :comments, :except => [:index, :show, :new] do
      member do
        get :show_reply
        get :reply
        post :create_reply
      end
    end
  end

  match "/categories/:category_id/events" => "events#index", :as => "events_from_category"
  get "events/add_source"
  get "events/remove_source"
  resources :events do
    resources :comments, :except => [:index, :show, :new] do
      member do
        get :show_reply
        get :reply
        post :create_reply
      end
    end  
  end
  
  # get "tips/remove_source" # TO ADD
  match "presentation_picture" => "presentation_pictures#destroy", :via => 'delete', :as => 'delete_presentation_picture'
  match "presentation_picture" => "presentation_pictures#new", :via => 'get', :as => 'new_presentation_picture'
  match "presentation_picture" => "presentation_pictures#create", :via => 'post', :as => 'create_presentation_picture'
  match "/categories/:category_id/tips" => "tips#index", :as => "tips_from_category"
  get "tips/add_source"
  get "tips/remove_source"
  resources :tips do
    # resources :comments, :except => [:index, :show, :new] do
    #   member do
    #     get :show_reply
    #     get :reply
    #     post :create_reply
    #   end
    # end
  end
  
  match "/categories/:category_id/questions" => "questions#index", :as => "questions_from_category"
  # match 'questions/:question_id/vote_up' => 'votes#vote_up', :as => "vote_up"
  # match 'questions/:question_id/vote_down' => 'votes#vote_down', :as => "vote_down"
  get "questions/add_source"
  get "questions/remove_source"
  resources :questions do
    resources :answers do
      member do
        post :vote_up
        post :vote_down
      end
    end
  end

  match "/categories/:category_id/posts" => "posts#index", :as => "posts_from_category"        # TO CHANGE
  get "posts/add_source"
  get "posts/remove_source"
  # match 'posts/:post_id/vote_up' => 'votes#vote_up', :as => "vote_up"
  # match 'posts/:post_id/vote_down' => 'votes#vote_down', :as => "vote_down"
  resources :posts do
    resources :upload_pictures
    resources :comments, :except => [:index, :show, :new] do
      member do
        get :show_reply
        get :reply
        post :create_reply
      end
    end
  end
  
  match '/vote_up/:voteable_type/:voteable_id' => 'votes#vote_up', :as => "vote_up"
  
  resources :newsletter_subscribers, :except => [:show, :new]

  get "contact_us/new"

  post "contact_us/send_email"

  get "error_pages/javascript_disabled"
  
  
  resources :post_types

  # resources :types

  resources :categories
  
  # resources :comments, :except => [:index, :show, :new] do
  #   member do
  #     get :show_reply
  #     get :reply
  #     post :create_reply
  #   end
  # end
  
  match 'comments/:commentable_type/:commentable_id/create' => 'comments#create', :as => "create_comment", :via => 'post'
  match 'comments/:commentable_type/:commentable_id/create_as_guest' => 'comments#create_as_guest', :as => "create_comment_as_guest", :via => 'post'
  match 'comments/:commentable_type/:commentable_id/show_guest_fields' => 'comments#show_guest_fields', :as => "show_comment_guest_fields", :via => 'get'
  match 'comments/:commentable_type/:commentable_id/:root_comment_id/show_reply' => 'comments#show_reply', :as => "show_comment_reply", :via => 'get'
  match 'comments/:commentable_type/:commentable_id/:root_comment_id/show_guest_fields_for_reply' => 'comments#show_guest_fields_for_reply', :as => "show_guest_fields_for_comment_reply", :via => 'get'
  match 'comments/:commentable_type/:commentable_id/:root_comment_id/create_reply' => 'comments#create_reply', :as => "create_comment_reply", :via => 'post'
  match 'comments/:commentable_type/:commentable_id/:root_comment_id/create_reply_as_guest' => 'comments#create_reply_as_guest', :as => "create_comment_reply_as_guest", :via => 'post'
  match 'comments/:commentable_type/:commentable_id/:id/edit' => 'comments#edit', :as => "edit_comment", :via => 'get'
  match 'comments/:commentable_type/:commentable_id/:id/update' => 'comments#update', :as => "update_comment", :via => 'put'
  match 'comments/:id/destroy' => 'comments#destroy', :as => "destroy_comment", :via => 'delete'
    
  get 'posts/archives'
  


  get "pages/home"
  
  get "pages/about"
  
  get "pages/contact"

  get "pages/search"
  
  get "pages/tips"
  
  
  devise_for :users, :controllers => {:sessions => 'sessions', :registrations => 'registrations'} do
    match "admin/users/sign_up" => "admin/registrations#new", :as => :admin_new_user_registration, :via => :get
    match "admin/users/destroy/:id" => "admin/registrations#destroy", :as => :admin_destroy_user_registration, :via => :delete
    match "admin/users/:id" => "admin/registrations#edit", :as => :admin_edit_user_registration, :via => :get
    match "admin/users/:id" => "admin/registrations#update", :as => :admin_update_user_registration, :via => :put
    match "admin/users" => "admin/registrations#create", :as => :admin_user_registration, :via => :post
  end
  match "users/profile/:id" => "users#show", :as => "show_user_profile"
  
  # namespace :admin do
  #   resources :users# , :controllers => {:registrations => 'admin'}
  # end
  
  # scope "/admin" do
  #   devise_for :users, :controllers => {:registrations => 'registrations'}
  # end :except => [:sessions, :registrations, :confirmations, :passwords]
  
  # , :only => :registrations
  
  # match "admin" => "pages#admin", :as => :admin_page
  
  namespace :admin do
    match "dashboard" => "dashboards#index", :as => :dashboard_page, :via => :get
    match "users" => "dashboards#user_index", :as => :users, :via => :get
  end
  # namespace :admin do
  #   # devise_for :users, :only => :registrations, :skip_helpers => true do
  #   
  #   match "users/sign_up" => "registrations#new", :as => :new_user_registration, :via => :get
  #   post "users/:id" => "registrations#create", :as => :user_registration
  #     # get   "private_customer/sign_in" => "main#index", :as => :private_customer_signin
  #   # end
  # end
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
  root :to => "pages#home"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
