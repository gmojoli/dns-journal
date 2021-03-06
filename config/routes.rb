DnsJournal::Application.routes.draw do


  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  root 'home#index'

  devise_for :users, :controllers => {:sessions => "sessions"}

  get "home/index"

  resources :domains do
    resources :dns_zones, :only => [:new, :create, :destroy, :show, :edit, :update] do
      resources :soa_sections, :only => [:edit, :create, :update, :destroy]
      resources :resource_records, :only => [:new, :show, :edit, :create, :update, :destroy]
    end
  end

  get 'resource_record_description/:type' => 'resource_records#resource_record_description', as: :resource_record_description

  get '/domains/:id/export/:dns_zone' => 'domains#export_zone', as: :export
  get '/domains/:id/select/:dns_zone' => 'domains#select_dns_zone', as: :select

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
