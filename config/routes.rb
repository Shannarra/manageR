# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
               registrations: :registrations
             }#, skip: %i[registrations]

  resources :users#, only: %i[show index edit manage new create]
  get 'my_profile', :to => 'users#my_profile'
  get 'manage', :to => 'users#manage'
  post 'create_user', :to => 'users#create'


  get 'welcome/index'

  root 'welcome#index'
end
