Rails.application.routes.draw do
   root to: 'toppage#index'
   
   get 'signup', to: 'users#new'
   resources :users
end
