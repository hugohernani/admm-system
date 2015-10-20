Rails.application.routes.draw do
  root 'blog/bloggers#index'
  devise_for :users

  namespace :blog do
    root 'bloggers#index'
    resources :bloggers
  end
end
