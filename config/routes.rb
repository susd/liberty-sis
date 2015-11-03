Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", sessions: 'sessions' }

  get 'forbidden', to: 'pages#forbidden', as: :forbidden

  concern :searchable do
    get :search, on: :collection
  end

  concern :pdfs do
    member do
      patch :generate
      patch :clear
      get :check
      get :show_cached
    end
  end

  resources :sites do
    resources :classrooms, only: :index
  end

  resources :classrooms, only: [:index, :show], concerns: :pdfs do

    scope module: 'classrooms' do
      resources :memberships, only: [:index, :destroy]
      resources :leaderships, only: [:index, :create, :destroy]
    end
  end

  resources :students, concerns: :searchable do
    resources :personas do
      patch :sync, on: :member
    end
    resources :report_cards, concerns: :pdfs

    scope module: 'students' do
      resources :classrooms, only: [:index, :destroy]
    end
  end

  get 'employees/search', to: 'employees#search', as: :search_employees

  namespace :admin do
    resources :users, except: [:new, :create], concerns: [:searchable]
    resources :employees, concerns: [:searchable]
    resources :roles
    resources :sites
  end

  namespace :report_cards do
    resources :grading_periods
    resources :forms do
      resources :subjects
      resources :comments
    end
  end

  root to: 'dashboard#index'

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
