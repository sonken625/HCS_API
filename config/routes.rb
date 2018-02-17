Rails.application.routes.draw do
  resources :queries
  devise_for :hcts,:skip => [:sessions,:passwords]
  resources :firms
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
