# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
               registrations: :registrations
             }

  resources :users do
    collection do
      get 'my_profile', :to => 'users#my_profile'
      get 'manage', :to => 'users#manage'
      get 'verify_code', :to => 'users#verify_code'
      patch 'update_user', :to => 'users#update'
      post 'create_user', :to => 'users#create'
    end
  end

  resources :institutions, param: :institution_id do
    member do
      get :show
      resources :i_classes, path: 'classes', as: 'classes', param: :id
    end
  end

  root 'users#my_profile'

  match '*unmatched', to: 'application#action_not_found', via: :all
end
