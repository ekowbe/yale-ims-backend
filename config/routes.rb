Rails.application.routes.draw do
  resources :players
  resources :matches
  resources :sport_teams
  resources :teams
  resources :colleges
  resources :sports
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

