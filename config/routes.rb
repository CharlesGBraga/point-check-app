# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/point_check_app/api-docs'
  mount Rswag::Api::Engine => '/point_check_app/api-docs'

  root to: 'welcome#index'

  resources :authentications, only: :create
  resources :users
  resources :points
end
