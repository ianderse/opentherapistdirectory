Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  root 'home#index'

  namespace :admin do
  	get 'dashboard',   to: 'dashboard#show',    as: 'dashboard'

    get 'facilities',  to: 'facilities#index',  as: 'facilities'
    post 'facilities', to: 'facilities#import', as: 'import_facilities'
  end

  get 'facilities',    to: 'facilities#index',  as: 'facilities'
end
