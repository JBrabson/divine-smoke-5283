Rails.application.routes.draw do
  resources :plots, only: [:index] do
    resources :plants, only: [:destroy], controller: :plot_plants
  end
  resources :plants, only: [:index]
end
