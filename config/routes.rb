Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root "static_pages#home"
  get "static_pages/about"

  resources :users do
    resources :questions
  end
  resources :exams

  namespace :admin do
    root "users#index"
    resources :exams, only: [:show, :index, :destroy, :update]
    resources :questions
    resources :users
    resources :subjects
    resources :activities, only: [:index]
  end
end
