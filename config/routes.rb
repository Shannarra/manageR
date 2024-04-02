# frozen_string_literal: true

Rails.application.routes.draw do
  authenticated :user do
    root to: 'institutions#index', as: :authenticated_user
  end

  root 'welcome#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
               registrations: :registrations
             }

  resources :users, except: %i[index] do
    collection do
      get :my_profile
      get :manage
      get :verify_code
      patch 'update_user', :to => 'users#update'
      post 'create_user', :to => 'users#create'
    end
  end

  resources :institutions, param: :institution_name do
    collection do
      get :manage
    end
    member do
      get :show
      resources :i_classes, path: 'classes', as: 'classes', param: :class_name do
        collection do
          get :manage
        end
        member do
          get 'create_new', to: 'i_classes#new'
          get :show
          get :edit
          patch :update
          post :create

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

  resources :exams do
    collection do
      get :upcoming
    end
  end

  # Disable FE views for grading systems, only admins should be able to mod
  # GradingSystem objects via AA.
  resources :grading_systems, only: []
  resources :grades do
    collection do
      get :mine
    end
  end

  match '*unmatched', to: 'application#action_not_found', via: :all
end
