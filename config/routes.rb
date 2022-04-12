# frozen_string_literal: true

Rails.application.routes.draw do
  root "subscribers#new"
  resources :subscribers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
