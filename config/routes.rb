# frozen_string_literal: true

Rails.application.routes.draw do
  resources :institutions
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
               registrations: :registrations
             }

  resources :users
  get 'my_profile', :to => 'users#my_profile'
  get 'manage', :to => 'users#manage'
  get 'verify_code', :to => 'users#verify_code'
  patch 'update_user', :to => 'users#update'
  post 'create_user', :to => 'users#create'

  root 'users#my_profile'
end
