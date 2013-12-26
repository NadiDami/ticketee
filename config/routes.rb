Ticketee::Application.routes.draw do
  root "projects#index"

  get "/signin", to: "sessions#new"
  post "/signin", to: "sessions#create"

  resources :projects do
    resources :tickets
  end

  resources :users

  namespace :admin do
    resources :users
  end

end
