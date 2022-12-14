# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
  root to: 'welcome#index'
  resources :authentications, only: :create
  resources :users, only: %w[index show create update destroy]
end
