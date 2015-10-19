Rails.application.routes.draw do
  resources :bloggers
  root 'bloggers#index'
  devise_for :users
end
