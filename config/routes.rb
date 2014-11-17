Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  namespace :admin do
    resources :facilities
    get 'dashboard', to: 'dashboard#show'
  end
end
