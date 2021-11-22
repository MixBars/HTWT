Rails.application.routes.draw do  
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  scope '(:locale)', locale: /en|ru/ do
    
    devise_for :users, skip: :omniauth_callbacks
    resources :tags, only: [:show]
    resources :reviews do
      resources :likes
      resources :user_ratings
  
    end
    resources :users, only: [:index, :show, :edit, :update]


    root to: 'main_page#index'
    get "search", to: "search#search"
  end
end
