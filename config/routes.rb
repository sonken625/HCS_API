Rails.application.routes.draw do
  resources :request_messages
  resources :query_definitions, param: :search_key do
    resource :search_key ,only:[:update], module: "query_definitions"
  end

  devise_for :hcts,:skip => [:sessions,:passwords]
  resources :firms
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
