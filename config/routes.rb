Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"
  get "static_pages/about"

  resources :users do
    resources :questions
  end

  namespace :admin do
    root "users#index"
    resources :users
    resources :subjects
  end
end
