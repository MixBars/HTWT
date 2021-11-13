Rails.application.routes.draw do  
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  scope '(:locale)', locale: /en|ru/ do
    

    resources :reviews

    root to: 'reviews#index'
  end
end
