Rails.application.routes.draw do
  root 'bloggers#index'
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  scope "blog", as: 'blog' do
    root 'bloggers#index'
    resources :bloggers
    resources :posts do
      member do
        put 'toggle_comments'
        put 'toggle_activation'
      end
      put 'list_by_activation', to: 'posts#list_by_activation', on: :collection
      resources :comments, only: [:create, :destroy]
    end
  end
end
