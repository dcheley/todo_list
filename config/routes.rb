Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'to_dos#index'

  resources :users, only: [:new, :create, :edit, :update]
  resources :to_dos

  get 'login' => 'sessions#new', as: :login
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy', as: :logout

  get 'calendar' => 'to_dos#calendar', as: :calendar
  get 'history' => 'to_dos#history', as: :history
end
