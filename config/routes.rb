Rails.application.routes.draw do
  scope '(:locale)', locale: /en|ru/ do
        
    root to: 'reviews#index'
  end
end
