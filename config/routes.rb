Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root 'recruitments#top'
  resources :recruitments, only: [:index]
  get 'my_profile', to: 'users#my_profile'
end
