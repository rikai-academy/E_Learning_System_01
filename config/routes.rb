Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root 'sessions#new'
    get '/home',          to: 'users#show'
    get '/signup',        to: 'users#new'
    get '/cate',          to: 'static_pages#categories'
    get '/login',         to: 'sessions#new'
    post '/login',        to: 'sessions#create'
    delete '/logout',     to: 'sessions#destroy'
  end
  resources :users
end
