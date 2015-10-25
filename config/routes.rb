Rails.application.routes.draw do
  root 'bloggers#index'
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  resources :users, only: [:index, :show]

  scope "blog", as: 'blog' do
    root 'bloggers#index'
    resources :bloggers do
      resources :themes
    end
    resources :posts do
      member do
        put 'toggle_comments'
        put 'toggle_activation'
      end
      resources :comments, only: [:create, :destroy]
    end
  end
end
