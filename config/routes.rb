# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'sessions#new'

  resource :sessions, only: %i[new create destroy]

  namespace :admin do
    root to: 'places#index'

    resources :administrators
    resources :places
  end

  namespace :api do
    resources :places, only: :index
  end
end
