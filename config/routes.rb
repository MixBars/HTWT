Rails.application.routes.draw do  
  scope '(:locale)', locale: /en|ru/ do
    devise_for :users

    

    root to: 'reviews#index'
  end
end
