Rails.application.routes.draw do
  get 'stocks_sold_per_people/new'
  get 'stocks_sold_per_people/index'
  get 'stocks_purchased_per_people/new'
  get 'stocks_purchased_per_people/index'
  get 'download_pdf', to: 'static#download_pdf'
  get '/stocks', to: 'stocks#show'
  get 'transactions/index'
  get 'deposits/index'
  get 'withdraws/index'
  get '/withdraw', to: 'withdraws#new'
  get '/deposit', to: 'deposits#new'
  post '/depositMoney', to:'deposits#create'
  post 'withdrawMoney', to: 'withdraws#create'

  get '/buy', to: 'stocks_purchased_per_people#create'
  get '/sell', to: 'stocks_sold_per_people#create'

  get 'stocks/index'

  get 'sessions/new'
  get 'users/new'
  get 'users/show'
  get 'user/new'
  get 'user/show'
  get 'static/about_seth'
  get 'static/home'
  get '/search', to: 'static#home'

  resources :users
  resources :deposits
  get    '/signup',  to: 'users#new'
  post   '/signup',  to: 'users#create'

  get 			'/login', 		to: 'sessions#new'
  post 		'/login', 		to: 'sessions#create'
  delete 		'/logout', 		to: 'sessions#destroy'

  # get '/search', to: 'deposits#index'




  root 'static#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
