Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "sessions#new"
    get "/home",          to: "users#show"
    get "/signup",        to: "users#new"
    get "/cate",          to: "static_pages#categories"
    get "/test",          to: "lessons#test"
    post "/result_test",    to: "lessons#result_test"
    get "/result_test",     to: "lessons#result_test"
    get "/login",         to: "sessions#new"
    post "/login",        to: "sessions#create"
    delete "/logout",     to: "sessions#destroy"
    get "/signup",        to: "users#new"
    get "/word_summary",  to: "summaries#word_summary"
  end
  resources :summaries
  resources :users
  resources :wordlists
  resources :lessons
  resources :categories
end