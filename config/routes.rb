# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

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
    collection do
      get 'manage', :to => 'institutions#manage'
    end
    member do
      get :show
      resources :i_classes, path: 'classes', as: 'classes', param: :class_id, only: :show do
        collection do
          get 'manage', :to => 'i_classes#manage'
        end
        member do
          get :edit
          patch :update

          resources :subjects, path: 'subjects', as: 'subjects', param: :subject_id
        end
      end
    end
  end

  resources :attendances do
    collection do
      get :multi
      post :start_multi

      get :continue_multi
      post :save_multi
    end
  end

  resources :exams

  match '*unmatched', to: 'application#action_not_found', via: :all
end
