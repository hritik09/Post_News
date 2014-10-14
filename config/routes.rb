Svasth::Application.routes.draw do
  resources :users do
    member do
      get :read, :unread
    end
  end
  resources :sessions,      only: [:new, :create, :destroy]
  resources :posts,    only: [:create, :destroy, :show]
  resources :readings, only: [:create, :destroy]
  root to: 'static_pages#home'
  match 'show',     to: 'post#show',            via: 'get'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
end
