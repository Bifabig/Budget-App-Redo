Rails.application.routes.draw do
  devise_for :users
  # get 'entities/index'
  # get 'groups/index'
  # get 'users/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  devise_scope :user do
    authenticated :user do
      root to: 'groups#index', as: :authenticated_root
    end

    unauthenticated :user do
      root to: 'devise/sessions#splash', as: :unauthenticated_root
    end
  end

  resources :groups do
    resources :entities do
    end
  end
end
