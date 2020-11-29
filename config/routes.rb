Rails.application.routes.draw do
  root "recruitments#top"
  resources :recruitments, only: [:index]
  post "recruitments/later/new", to: "recruitments#new_later"
  post "recruitments/now/new", to: "recruitments#new_now"
  post "recruitments/later/create", to: "recruitments#create_later"
  post "recruitments/now/create", to: "recruitments#create_now"
  post "recruitments/later/edit", to: "recruitments#edit_later"
  post "recruitments/now/edit", to: "recruitments#edit_now"
  post "recruitments/later/update", to: "recruitments#update_later"
  post "recruitments/now/update", to: "recruitments#update_now"

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  get "profile", to: "users#profile"
  post "profile/update", to: "users#update"
  get "users/search", to: "users#search"

  resources :friends, only: [:index]
  get "friends/mutual", to: "friends#mutual"
  get "friends/oneway_followers", to: "friends#oneway_followers"
  get "friends/oneway_followings", to: "friends#oneway_followings"
  post "friends/:id/heart", to: "friends#heart"
end
