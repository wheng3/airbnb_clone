# if Clearance.configuration.routes_enabled?
  Rails.application.routes.draw do

  root to: "listings#index"

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create, :edit, :update] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
    resources :listings
  end

  resources :listings, only: [] do
      resources :reservations, only: [:create, :destroy]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get "/superadmin_secret" => "users#superadmin_secret"

  get "/listings" => "users#listings", as: "listings"
  get "/reservations" => "users#reservations", as: "reservations"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end