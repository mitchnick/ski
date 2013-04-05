Wheretoski::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  get "static_pages/home"
  get "users/new"

  authenticated :user do
    root :to => 'static_pages#home'
  end

  root to: 'static_pages#home'
  devise_for  :users, 
              :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, :only => [] do
    collection do
      get 'current'
      get 'edit'
      put 'update_password'
    end
  end
  resources :users 
  resources :regions
  resources :mountains do
    resources :photos
  end
  resources :photo_relationships
  resources :gnars
  resources :my_mountains
  resources :view_counts

  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/search',  to: 'static_pages#search'
  match 'auth/facebook/callback' => redirect("/users/auth/facebook")

  # match 'auth/:provider/callback', to: 'authentications#create'
  # OR
  # match 'auth/:provider/callback', to: 'users/omniauth_callbacks#facebook'

  # match 'auth/failure', to: redirect('/')
  # match 'signout', to: 'authentications#signout', as: 'signout'
  # TODO: Verify which of the three lines above are required since I'm using devise

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
#== Route Map
# Generated on 27 Mar 2013 16:42
#
#         batch_action_admin_admin_users POST       /admin/admin_users/batch_action(.:format)         admin/admin_users#batch_action
#                      admin_admin_users GET        /admin/admin_users(.:format)                      admin/admin_users#index
#                                        POST       /admin/admin_users(.:format)                      admin/admin_users#create
#                   new_admin_admin_user GET        /admin/admin_users/new(.:format)                  admin/admin_users#new
#                  edit_admin_admin_user GET        /admin/admin_users/:id/edit(.:format)             admin/admin_users#edit
#                       admin_admin_user GET        /admin/admin_users/:id(.:format)                  admin/admin_users#show
#                                        PUT        /admin/admin_users/:id(.:format)                  admin/admin_users#update
#                                        DELETE     /admin/admin_users/:id(.:format)                  admin/admin_users#destroy
#                        admin_dashboard            /admin/dashboard(.:format)                        admin/dashboard#index
#               batch_action_admin_gnars POST       /admin/gnars/batch_action(.:format)               admin/gnars#batch_action
#                            admin_gnars GET        /admin/gnars(.:format)                            admin/gnars#index
#                                        POST       /admin/gnars(.:format)                            admin/gnars#create
#                         new_admin_gnar GET        /admin/gnars/new(.:format)                        admin/gnars#new
#                        edit_admin_gnar GET        /admin/gnars/:id/edit(.:format)                   admin/gnars#edit
#                             admin_gnar GET        /admin/gnars/:id(.:format)                        admin/gnars#show
#                                        PUT        /admin/gnars/:id(.:format)                        admin/gnars#update
#                                        DELETE     /admin/gnars/:id(.:format)                        admin/gnars#destroy
#             upload_csv_admin_mountains GET        /admin/mountains/upload_csv(.:format)             admin/mountains#upload_csv
#             import_csv_admin_mountains POST       /admin/mountains/import_csv(.:format)             admin/mountains#import_csv
#           batch_action_admin_mountains POST       /admin/mountains/batch_action(.:format)           admin/mountains#batch_action
#                        admin_mountains GET        /admin/mountains(.:format)                        admin/mountains#index
#                                        POST       /admin/mountains(.:format)                        admin/mountains#create
#                     new_admin_mountain GET        /admin/mountains/new(.:format)                    admin/mountains#new
#                    edit_admin_mountain GET        /admin/mountains/:id/edit(.:format)               admin/mountains#edit
#                         admin_mountain GET        /admin/mountains/:id(.:format)                    admin/mountains#show
#                                        PUT        /admin/mountains/:id(.:format)                    admin/mountains#update
#                                        DELETE     /admin/mountains/:id(.:format)                    admin/mountains#destroy
#        batch_action_admin_my_mountains POST       /admin/my_mountains/batch_action(.:format)        admin/my_mountains#batch_action
#                     admin_my_mountains GET        /admin/my_mountains(.:format)                     admin/my_mountains#index
#                                        POST       /admin/my_mountains(.:format)                     admin/my_mountains#create
#                  new_admin_my_mountain GET        /admin/my_mountains/new(.:format)                 admin/my_mountains#new
#                 edit_admin_my_mountain GET        /admin/my_mountains/:id/edit(.:format)            admin/my_mountains#edit
#                      admin_my_mountain GET        /admin/my_mountains/:id(.:format)                 admin/my_mountains#show
#                                        PUT        /admin/my_mountains/:id(.:format)                 admin/my_mountains#update
#                                        DELETE     /admin/my_mountains/:id(.:format)                 admin/my_mountains#destroy
#              batch_action_admin_photos POST       /admin/photos/batch_action(.:format)              admin/photos#batch_action
#                           admin_photos GET        /admin/photos(.:format)                           admin/photos#index
#                                        POST       /admin/photos(.:format)                           admin/photos#create
#                        new_admin_photo GET        /admin/photos/new(.:format)                       admin/photos#new
#                       edit_admin_photo GET        /admin/photos/:id/edit(.:format)                  admin/photos#edit
#                            admin_photo GET        /admin/photos/:id(.:format)                       admin/photos#show
#                                        PUT        /admin/photos/:id(.:format)                       admin/photos#update
#                                        DELETE     /admin/photos/:id(.:format)                       admin/photos#destroy
# batch_action_admin_photo_relationships POST       /admin/photo_relationships/batch_action(.:format) admin/photo_relationships#batch_action
#              admin_photo_relationships GET        /admin/photo_relationships(.:format)              admin/photo_relationships#index
#                                        POST       /admin/photo_relationships(.:format)              admin/photo_relationships#create
#           new_admin_photo_relationship GET        /admin/photo_relationships/new(.:format)          admin/photo_relationships#new
#          edit_admin_photo_relationship GET        /admin/photo_relationships/:id/edit(.:format)     admin/photo_relationships#edit
#               admin_photo_relationship GET        /admin/photo_relationships/:id(.:format)          admin/photo_relationships#show
#                                        PUT        /admin/photo_relationships/:id(.:format)          admin/photo_relationships#update
#                                        DELETE     /admin/photo_relationships/:id(.:format)          admin/photo_relationships#destroy
#             batch_action_admin_regions POST       /admin/regions/batch_action(.:format)             admin/regions#batch_action
#                          admin_regions GET        /admin/regions(.:format)                          admin/regions#index
#                                        POST       /admin/regions(.:format)                          admin/regions#create
#                       new_admin_region GET        /admin/regions/new(.:format)                      admin/regions#new
#                      edit_admin_region GET        /admin/regions/:id/edit(.:format)                 admin/regions#edit
#                           admin_region GET        /admin/regions/:id(.:format)                      admin/regions#show
#                                        PUT        /admin/regions/:id(.:format)                      admin/regions#update
#                                        DELETE     /admin/regions/:id(.:format)                      admin/regions#destroy
#               batch_action_admin_users POST       /admin/users/batch_action(.:format)               admin/users#batch_action
#                            admin_users GET        /admin/users(.:format)                            admin/users#index
#                                        POST       /admin/users(.:format)                            admin/users#create
#                         new_admin_user GET        /admin/users/new(.:format)                        admin/users#new
#                        edit_admin_user GET        /admin/users/:id/edit(.:format)                   admin/users#edit
#                             admin_user GET        /admin/users/:id(.:format)                        admin/users#show
#                                        PUT        /admin/users/:id(.:format)                        admin/users#update
#                                        DELETE     /admin/users/:id(.:format)                        admin/users#destroy
#            batch_action_admin_comments POST       /admin/comments/batch_action(.:format)            admin/comments#batch_action
#                         admin_comments GET        /admin/comments(.:format)                         admin/comments#index
#                                        POST       /admin/comments(.:format)                         admin/comments#create
#                          admin_comment GET        /admin/comments/:id(.:format)                     admin/comments#show
#                 new_admin_user_session GET        /admin/login(.:format)                            active_admin/devise/sessions#new
#                     admin_user_session POST       /admin/login(.:format)                            active_admin/devise/sessions#create
#             destroy_admin_user_session DELETE|GET /admin/logout(.:format)                           active_admin/devise/sessions#destroy
#                    admin_user_password POST       /admin/password(.:format)                         active_admin/devise/passwords#create
#                new_admin_user_password GET        /admin/password/new(.:format)                     active_admin/devise/passwords#new
#               edit_admin_user_password GET        /admin/password/edit(.:format)                    active_admin/devise/passwords#edit
#                                        PUT        /admin/password(.:format)                         active_admin/devise/passwords#update
#                      static_pages_home GET        /static_pages/home(.:format)                      static_pages#home
#                              users_new GET        /users/new(.:format)                              users#new
#                                   root            /                                                 static_pages#home
#                                   root            /                                                 static_pages#home
#                       new_user_session GET        /users/sign_in(.:format)                          devise/sessions#new
#                           user_session POST       /users/sign_in(.:format)                          devise/sessions#create
#                   destroy_user_session DELETE     /users/sign_out(.:format)                         devise/sessions#destroy
#                user_omniauth_authorize            /users/auth/:provider(.:format)                   users/omniauth_callbacks#passthru {:provider=>/facebook/}
#                 user_omniauth_callback            /users/auth/:action/callback(.:format)            users/omniauth_callbacks#(?-mix:facebook)
#                          user_password POST       /users/password(.:format)                         devise/passwords#create
#                      new_user_password GET        /users/password/new(.:format)                     devise/passwords#new
#                     edit_user_password GET        /users/password/edit(.:format)                    devise/passwords#edit
#                                        PUT        /users/password(.:format)                         devise/passwords#update
#               cancel_user_registration GET        /users/cancel(.:format)                           devise/registrations#cancel
#                      user_registration POST       /users(.:format)                                  devise/registrations#create
#                  new_user_registration GET        /users/sign_up(.:format)                          devise/registrations#new
#                 edit_user_registration GET        /users/edit(.:format)                             devise/registrations#edit
#                                        PUT        /users(.:format)                                  devise/registrations#update
#                                        DELETE     /users(.:format)                                  devise/registrations#destroy
#                      user_confirmation POST       /users/confirmation(.:format)                     devise/confirmations#create
#                  new_user_confirmation GET        /users/confirmation/new(.:format)                 devise/confirmations#new
#                                        GET        /users/confirmation(.:format)                     devise/confirmations#show
#                          current_users GET        /users/current(.:format)                          users#current
#                             edit_users GET        /users/edit(.:format)                             users#edit
#                  update_password_users PUT        /users/update_password(.:format)                  users#update_password
#                                  users GET        /users(.:format)                                  users#index
#                                        POST       /users(.:format)                                  users#create
#                               new_user GET        /users/new(.:format)                              users#new
#                              edit_user GET        /users/:id/edit(.:format)                         users#edit
#                                   user GET        /users/:id(.:format)                              users#show
#                                        PUT        /users/:id(.:format)                              users#update
#                                        DELETE     /users/:id(.:format)                              users#destroy
#                        mountain_photos GET        /mountains/:mountain_id/photos(.:format)          photos#index
#                                        POST       /mountains/:mountain_id/photos(.:format)          photos#create
#                     new_mountain_photo GET        /mountains/:mountain_id/photos/new(.:format)      photos#new
#                    edit_mountain_photo GET        /mountains/:mountain_id/photos/:id/edit(.:format) photos#edit
#                         mountain_photo GET        /mountains/:mountain_id/photos/:id(.:format)      photos#show
#                                        PUT        /mountains/:mountain_id/photos/:id(.:format)      photos#update
#                                        DELETE     /mountains/:mountain_id/photos/:id(.:format)      photos#destroy
#                              mountains GET        /mountains(.:format)                              mountains#index
#                                        POST       /mountains(.:format)                              mountains#create
#                           new_mountain GET        /mountains/new(.:format)                          mountains#new
#                          edit_mountain GET        /mountains/:id/edit(.:format)                     mountains#edit
#                               mountain GET        /mountains/:id(.:format)                          mountains#show
#                                        PUT        /mountains/:id(.:format)                          mountains#update
#                                        DELETE     /mountains/:id(.:format)                          mountains#destroy
#                    photo_relationships GET        /photo_relationships(.:format)                    photo_relationships#index
#                                        POST       /photo_relationships(.:format)                    photo_relationships#create
#                 new_photo_relationship GET        /photo_relationships/new(.:format)                photo_relationships#new
#                edit_photo_relationship GET        /photo_relationships/:id/edit(.:format)           photo_relationships#edit
#                     photo_relationship GET        /photo_relationships/:id(.:format)                photo_relationships#show
#                                        PUT        /photo_relationships/:id(.:format)                photo_relationships#update
#                                        DELETE     /photo_relationships/:id(.:format)                photo_relationships#destroy
#                                  gnars GET        /gnars(.:format)                                  gnars#index
#                                        POST       /gnars(.:format)                                  gnars#create
#                               new_gnar GET        /gnars/new(.:format)                              gnars#new
#                              edit_gnar GET        /gnars/:id/edit(.:format)                         gnars#edit
#                                   gnar GET        /gnars/:id(.:format)                              gnars#show
#                                        PUT        /gnars/:id(.:format)                              gnars#update
#                                        DELETE     /gnars/:id(.:format)                              gnars#destroy
#                           my_mountains GET        /my_mountains(.:format)                           my_mountains#index
#                                        POST       /my_mountains(.:format)                           my_mountains#create
#                        new_my_mountain GET        /my_mountains/new(.:format)                       my_mountains#new
#                       edit_my_mountain GET        /my_mountains/:id/edit(.:format)                  my_mountains#edit
#                            my_mountain GET        /my_mountains/:id(.:format)                       my_mountains#show
#                                        PUT        /my_mountains/:id(.:format)                       my_mountains#update
#                                        DELETE     /my_mountains/:id(.:format)                       my_mountains#destroy
#                                  about            /about(.:format)                                  static_pages#about
#                                contact            /contact(.:format)                                static_pages#contact
#                                 search            /search(.:format)                                 static_pages#search
#                 auth_facebook_callback            /auth/facebook/callback(.:format)                 :controller#:action
