Changeons::Application.routes.draw do
  

  resources :product_tests do
    resources :comments, :except => [:index, :show, :new] do
      member do
        get :show_reply
        get :reply
        post :create_reply
      end
    end
  end

  resources :events do
    resources :comments, :except => [:index, :show, :new] do
      member do
        get :show_reply
        get :reply
        post :create_reply
      end
    end    
  end

  resources :tips do
    resources :comments, :except => [:index, :show, :new] do
      member do
        get :show_reply
        get :reply
        post :create_reply
      end
    end
  end

  resources :questions do
    resources :answers
  end
  
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
  
  resources :newsletter_subscribers, :except => [:show, :new]

  get "contact_us/new"

  post "contact_us/send_email"

  get "error_pages/javascript_disabled"
  
  
  resources :post_types

  # resources :types

  resources :categories
  
  match 'posts/:post_id/comments/show_guest_fields' => 'comments#show_guest_fields', :as => "post_show_guest_fields"
  match 'tips/:tip_id/comments/show_guest_fields' => 'comments#show_guest_fields', :as => "tip_show_guest_fields"
  match 'events/:event_id/comments/show_guest_fields' => 'comments#show_guest_fields', :as => "event_show_guest_fields"
  match 'product_tests/:product_test_id/comments/show_guest_fields' => 'comments#show_guest_fields', :as => "product_test_show_guest_fields"
  
  match 'posts/:post_id/comments/:id/show_guest_fields_for_reply' => 'comments#show_guest_fields_for_reply', :as => "post_show_guest_fields_for_reply"
  match 'tips/:tip_id/comments/:id/show_guest_fields_for_reply' => 'comments#show_guest_fields_for_reply', :as => "tip_show_guest_fields_for_reply"
  match 'events/:event_id/comments/:id/show_guest_fields_for_reply' => 'comments#show_guest_fields_for_reply', :as => "event_show_guest_fields_for_reply"
  match 'product_tests/:product_test_id/comments/:id/show_guest_fields_for_reply' => 'comments#show_guest_fields_for_reply', :as => "product_test_show_guest_fields_for_reply"
  
  match 'posts/:post_id/comments/create_comment_as_guest' => 'comments#create_comment_as_guest', :as => 'post_create_comment_as_guest', :via => 'post'
  match 'tips/:tip_id/comments/create_comment_as_guest' => 'comments#create_comment_as_guest', :as => 'tip_create_comment_as_guest', :via => 'post'
  match 'events/:event_id/comments/create_comment_as_guest' => 'comments#create_comment_as_guest', :as => 'event_create_comment_as_guest', :via => 'post'
  match 'product_tests/:product_test_id/comments/create_comment_as_guest' => 'comments#create_comment_as_guest', :as => 'product_test_create_comment_as_guest', :via => 'post'
  
  match 'posts/:post_id/comments/:id/create_reply_as_guest' => 'comments#create_reply_as_guest', :as => 'post_create_reply_as_guest', :via => 'post'
  match 'tips/:tip_id/comments/:id/create_reply_as_guest' => 'comments#create_reply_as_guest', :as => 'tip_create_reply_as_guest', :via => 'post'
  match 'events/:event_id/comments/:id/create_reply_as_guest' => 'comments#create_reply_as_guest', :as => 'event_create_reply_as_guest', :via => 'post'
  match 'product_tests/:product_test_id/comments/:id/create_reply_as_guest' => 'comments#create_reply_as_guest', :as => 'product_test_create_reply_as_guest', :via => 'post'
  
  post 'posts/show_more_posts', :as => 'show_more_posts'
  match 'posts/:post_id/show_more_comments' => 'comments#show_more_comments', :as => 'show_more_comments', :via => 'post'
  get 'posts/archives'
  


  get "pages/home"
  
  get "pages/about"
  
  get "pages/contact"

  get "pages/search"
  
  get "pages/tips"
  

  devise_for :users, :controllers => {:sessions => 'sessions'} do
    match "admin/users/sign_up" => "admin/registrations#new", :as => :admin_new_user_registration, :via => :get
    match "admin/users/destroy/:id" => "admin/registrations#destroy", :as => :admin_destroy_user_registration, :via => :delete
    match "admin/users/:id" => "admin/registrations#edit", :as => :admin_edit_user_registration, :via => :get
    match "admin/users/:id" => "admin/registrations#update", :as => :admin_update_user_registration, :via => :put
    match "admin/users" => "admin/registrations#create", :as => :admin_user_registration, :via => :post
  end
  
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
