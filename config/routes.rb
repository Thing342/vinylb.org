Rails.application.routes.draw do
  root 'static_pages#index'

  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get 'users/:uid/search', to: 'albums#search'

  resources :users,          only: [:new, :create, :index, :edit, :update, :destroy]
  resources :albums,         path: 'users/:uid'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
