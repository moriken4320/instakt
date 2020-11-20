Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  get 'my_profile', to: 'users#my_profile'
  resources :users, only: [:update]

  root 'recruitments#top'
  resources :recruitments, only: [:index]
end
