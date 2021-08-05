Rails.application.routes.draw do
  get 'summary/create'
  scope "(:locale)", locale: /en|vi/ do
    root "sessions#new"
    delete "/delete_summary", to: "summaries#unactive"
    post "/add_summary",  to: "summaries#create"
    get "/edit",          to: "users#edit"
    get "/home",          to: "users#show"
    get "/signup",        to: "users#new"
    get "/cate",          to: "static_pages#categories"
    get "/login",         to: "sessions#new"
    post "/login",        to: "sessions#create"
    delete "/logout",     to: "sessions#destroy"    
  end
  resources :summaries
  resources :users
  
end
