Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root 'static_pages#home'
    get '/cate', to: 'static_pages#categories'
  end
end
