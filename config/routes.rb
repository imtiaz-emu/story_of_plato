Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :organizations do
    member do
      post :add_user
    end
  end

  resources :subscriptions, except: [:update, :destroy, :edit]

  resources :projects, except: [:new, :edit]
  resources :profiles, only: [:show]

  root 'dashboard#index'

end
