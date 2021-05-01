require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Sidekiq::Web => "/sidekiq" # mount Sidekiq::Web in your Rails app
  devise_for :users
  root "dashboard#index"
end
