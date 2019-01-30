Rails.application.routes.draw do
  get 'posts/index'

  get 'posts/show'

  get 'users/edit'

  get 'comments/create'

  get 'comments/destroy'

  get 'likes/create'

  get 'likes/destroy'

  get 'relationships/create'

  get 'relationships/destroy'

  get 'posts/new'

  get 'posts/create'

  get 'posts/destroy'

  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  get 'users/index'

  get 'users/show'

  get 'users/new'

  get 'users/create'

  get 'toppages/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  get 'signup', to: 'users#new'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  
  resources :users, only: [:index, :show, :new, :create, :edit, :update] do
    member do
      get :followings
      get :followers
    end
  end
  
  resources :posts, only: [:index,:new, :create, :destroy, :show] do
    resources :comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  
  post 'likes/:post_id/create' => 'likes#create'
  post 'likes/:post_id/destroy' => 'likes#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
