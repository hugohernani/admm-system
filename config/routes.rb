Rails.application.routes.draw do
  root 'blog/bloggers#index'
  devise_for :users

  namespace :blog do
    root 'bloggers#index'
    resources :bloggers
    resources :posts do
      member do
        put 'toggle_comments'
        put 'toggle_activation'
      end
    resources :comments, only: [:create, :destroy]
    end
  end
end
