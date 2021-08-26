Rails.application.routes.draw do
  devise_for :users
  resources :courses
  resources :users
  get 'home/index'
  get 'home/activity'
  root 'home#index'
end
