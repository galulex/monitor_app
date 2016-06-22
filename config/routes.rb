Rails.application.routes.draw do
  root 'instances#index'

  resources :instances, only: [:new, :create, :show, :destroy]
  mount ActionCable.server => '/cable'
end
