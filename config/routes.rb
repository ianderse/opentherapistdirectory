require 'resque/server'

Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  root 'home#index'
  mount Resque::Server.new, at: "/resque"

  namespace :admin do
  	get 'dashboard',       to: 'dashboard#show',    as: 'dashboard'

    get 'facilities',      to: 'facilities#index',  as: 'facilities'
    post 'facilities',     to: 'facilities#import', as: 'import_facilities'
  end

  get 'facilities',        to: 'facilities#index',  as: 'facilities'
  get 'facilities/:id',    to: 'facilities#show',   as: 'facility'
  post 'facility/remove/:id', to: 'users#remove_facility', as: 'remove_facility'
  get 'contact',           to: 'home#contact',      as: 'contact'
  get 'user',              to: 'users#show',        as: 'user'
  get 'articles',          to: 'articles#index',    as: 'articles'

  post 'facility/save/:id',to: 'facilities#save_facility', as: 'save_facility'
end
