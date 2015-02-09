require 'resque/server'

Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => 'registrations' }
  root 'home#index'
  mount Resque::Server.new, at: "/resque"

  namespace :api do
    namespace :v1 do
      get 'facilities',         to: 'facilities#index',          as: 'facilities', defaults: {format: :json}
      get 'facilities/:id',     to: 'facilities#show',           as: 'facility', defaults: {format: :json}
      get 'therapists',         to: 'therapists#index',          as: 'therapists', defaults: {format: :json}
      get 'therapists/:id',     to: 'therapists#show',           as: 'therapist', defaults: {format: :json}
    end
  end

  namespace :admin do
  	get 'dashboard',            to: 'dashboard#show',            as: 'dashboard'

    get 'facilities',           to: 'facilities#index',          as: 'facilities'
    post 'facilities',          to: 'facilities#import',         as: 'import_facilities'
  end

  get  'facilities',            to: 'facilities#index',          as: 'facilities'
  get  'facilities/:id',        to: 'facilities#show',           as: 'facility'
  get  'facilities/share/:id',  to: 'facilities#share_facility', as: 'share_facility'
  post 'facilities/share',      to: 'facilities#share',          as: 'facilities_share'
  post 'facility/save/:id',     to: 'facilities#save_facility',  as: 'save_facility'
  post 'facility/remove/:id',   to: 'users#remove_facility',     as: 'remove_facility'

  get  'contact',               to: 'home#contact',              as: 'contact'
  post 'contact',               to: 'home#send_contact',         as: 'contact_us'

  get  'user',                  to: 'users#show',                as: 'user'

  get  'articles',              to: 'articles#index',            as: 'articles'
  get  'articles/share/:title', to: 'articles#show',             as: 'articles_show'
  post 'articles/share',        to: 'articles#share',            as: 'articles_share'

  get  'therapists',            to: 'therapists#index',          as: 'therapists'
  get  'therapists/new',        to: 'therapists#new',            as: 'new_therapist'
  get  'therapists/:id',        to: 'therapists#show',           as: 'therapist'
  get  'therapists/:id/edit',   to: 'therapists#edit',           as: 'edit_therapist'
  post 'therapists',            to: 'therapists#create'
end
