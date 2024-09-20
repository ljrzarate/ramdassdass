require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  mount Sidekiq::Web => "/sidekiq"

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "posts#index"

  resources :posts do
    resources :comments
  end

  namespace :paypal do
    resources :orders, only: [:create] do
      resource :captures, only: [:create]
    end
  end

  resources :chapters, only: [:index]
  resources :contact, only: [:index, :create]
  resources :spirituality_for_devs, only: [:index]
end
