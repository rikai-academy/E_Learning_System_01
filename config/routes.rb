Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "sessions#new"
    get "/home",          to: "users#show"
    get "/signup",        to: "users#new"
    get "/cate",          to: "static_pages#categories"
    get "/login",         to: "sessions#new"
    post "/login",        to: "sessions#create"
    delete "/logout",     to: "sessions#destroy"
    get "/signup",        to: "users#new"
    get "/word_summary",  to: "summaries#word_summary"
    get "result_test",    to: "tests#result_test"
    post "result_test",    to: "tests#result_test"
    resources :summaries
    resources :users
    resources :wordlists
    resources :lessons
    resources :categories
    resources :tests
  end
end