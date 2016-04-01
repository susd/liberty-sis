Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks", sessions: 'sessions' }

  authenticated :user, -> (user) { user.admin? } do
    mount Delayed::Web::Engine, at: '/jobs'
  end

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
      resources :personas, only: [:index]
    end
  end

  resources :students, concerns: :searchable do

    resources :report_cards, concerns: :pdfs

    scope module: 'students' do
      resources :classrooms, only: [:index, :destroy]
      resources :contacts, only: [:index]
      resources :personas do
        patch :sync, on: :member
      end
    end
  end

  resources :employees do
    collection do
      get :search
    end
  end

  namespace :admin do
    resources :users, except: [:new, :create], concerns: [:searchable]
    resources :employees, concerns: [:searchable]
    resources :roles
    resources :sites, except: [:destroy]
    resources :sync_events
  end

  namespace :report_cards do
    resources :grading_periods
    resources :forms do
      resources :subjects
      resources :comments
      resources :options, controller: 'form_options'
    end
  end

  namespace :gapps do
    resources :org_units

    namespace :api do
      resources :org_units, only: [:update, :destroy]
      resources :users, only: [:show, :create, :update, :destroy] do
        patch :suspend, on: :member
      end
    end

  end

  root to: 'dashboard#index'
end
