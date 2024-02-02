# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
               registrations: :registrations
             }

  resources :users
  get 'my_profile', :to => 'users#my_profile'
  get 'manage', :to => 'users#manage'
  post 'create_user', :to => 'users#create'

  root 'users#my_profile'
end
