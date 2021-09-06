Rails.application.routes.draw do
  devise_for :users,
              path: "",
              controllers: {omniauth_callbacks: "omniauth_callbacks" }
  scope "(:locale)", locale: /en|vi/ do
    root "sessions#new"
    get "/admin",         to: "admin#index"
    get "/down_lesson",      to: "lessons#down_lesson"
    get "/home",          to: "users#show"
    get "/signup",        to: "users#new"
    get "/cate",          to: "static_pages#categories"
    get "/login",         to: "sessions#new"
    post "/login",        to: "sessions#create"
    delete "/logout",     to: "sessions#destroy"
    get "/train",         to: "lessons#train"
    get "/signup",        to: "users#new"
    get "/word_summary",  to: "summaries#word_summary"
    resources :summaries
    resources :users do
      member do
        get :following, :followers
      end
    end
    resources :wordlists
    resources :lessons
    resources :categories
    resources :tests
    resources :relationships, only: [:create, :destroy]
    namespace :admin do
      resources :users
      resources :categories
      resources :questions
      resources :answers
      resources :lessons
      resources :content_lessons
    end
  end
end