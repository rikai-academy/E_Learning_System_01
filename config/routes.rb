Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root 'sessions#new'
    get '/edit',          to: 'users#edit'
    get '/home',          to: 'users#show'
    get '/signup',        to: 'users#new'
    get '/cate',          to: 'static_pages#categories'
    get '/login',         to: 'sessions#new'
    post '/login',        to: 'sessions#create'
    delete '/logout',     to: 'sessions#destroy'
  end
  devise_for :users,
              path: '',
              path_names: {sign_in: 'login' ,sign_out: 'logout' ,edit: 'profile',sign_up: 'resgistration'},
              controllers: {omniauth_callbacks: 'omniauth_callbacks' }
  resources :users
end
