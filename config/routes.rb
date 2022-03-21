Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  get 'users/show'
  get 'user/new'
  get 'user/show'
  get 'static/about_seth'
  get 'static/home'
  get '/search', to: 'static#home'

  resources :users
  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'

  get 			'/login', 		to: 'sessions#new'
  post 		'/login', 		to: 'sessions#create'
  delete 		'/logout', 		to: 'sessions#destroy'


  root 'static#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
