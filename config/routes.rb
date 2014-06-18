Rails.application.routes.draw do
  root 'games#index'
  get 'goals', to: 'games#goals', as: :goals
end
