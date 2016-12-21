Rails.application.routes.draw do

  mount Buttafly::Engine => "/buttafly"

  resources :dummy_children
  resources :dummy_parents
  resources :dummy_grandparents
  resources :dummy_tribes

end
