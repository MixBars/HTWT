Rails.application.routes.draw do  
  
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  scope '(:locale)', locale: /en|ru/ do
    
    devise_for :users, skip: :omniauth_callbacks
    resources :reviews

    get 'myReviews', to: 'reviews#myReviews'


    root to: 'reviews#index'
  end
end
