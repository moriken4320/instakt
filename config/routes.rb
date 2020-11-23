Rails.application.routes.draw do
  root "recruitments#top"
  resources :recruitments, only: [:index]

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  get "profile", to: "users#profile"
  post "profile/update", to: "users#update"

  resources :friends, only: [:index]
  get "friends/mutual", to: "friends#mutual"
  get "friends/oneway_followers", to: "friends#oneway_followers"
  get "friends/oneway_followings", to: "friends#oneway_followings"
end
