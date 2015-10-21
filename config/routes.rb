Rails.application.routes.draw do
  root 'bloggers#index'
  devise_for :users

  scope "blog", as: 'blog' do
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
