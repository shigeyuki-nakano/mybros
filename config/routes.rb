Rails.application.routes.draw do
   root to: 'toppage#index'
   
   get 'login', to: 'sessions#new'
   post 'login', to: 'sessions#create'
   delete 'logout', to: 'sessions#destroy'
   
   get 'signup', to: 'users#new'
   resources :users do
      member do
         get :followings
         get :followers
         get :likes  # 自分がいいねした投稿一覧用
      end
      collection do
         get :search
      end
   end
   
   resources :articles, except: [:index] do
      member do
         get :likes  # 投稿をいいねしたユーザー一覧用
         get :comments
      end
   end
   
   resources :relationships, only: [:create, :destroy]
   resources :favorites, only: [:create, :destroy]
   resources :comments, only: [:create, :destroy]
end
