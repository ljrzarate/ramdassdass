require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Sidekiq::Web => "/sidekiq"
  devise_for :users
  root "posts#index"

  resources :posts
  resources :chapters, only: [:index]
  resources :contact, only: [:index, :create]
  resources :spirituality_for_devs, only: [:index]

end
