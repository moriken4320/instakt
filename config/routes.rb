Rails.application.routes.draw do
  devise_for :users
  root 'recruitments#top'
end
