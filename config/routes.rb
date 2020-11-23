Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  get 'profile', to: 'users#profile'
  post 'profile/update', to: 'users#update'
  # put 'profile', to: 'users#profile'

  root 'recruitments#top'
  resources :recruitments, only: [:index]

  resources :friends, only: [:index]
end
