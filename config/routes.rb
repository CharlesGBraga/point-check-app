# frozen_string_literal: true

require 'sidekiq/web'

Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use Rails.application.config.session_store, Rails.application.config.session_options

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/point_check_app/api-docs'
  mount Rswag::Api::Engine => '/point_check_app/api-docs'

  root to: 'welcome#index'

  resources :authentications, only: :create
  resources :users
  resources :points

  mount Sidekiq::Web => "/sidekiq"
end
