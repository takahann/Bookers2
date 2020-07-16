Rails.application.routes.draw do
  devise_for :users
  root 'homes#top'
  get 'home/about', to: 'homes#about'
  get 'search' => 'search#search'
  resources :users, only:[:show, :edit, :update, :index,:create] do
    member do
     get :following, :followers
   end
end
  resources :relationships, only: [:create, :destroy]
  resources :books, only:[:new, :create,:index,:show,:edit,:update,:destroy] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
