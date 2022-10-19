Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :authentications, only: :create
end
