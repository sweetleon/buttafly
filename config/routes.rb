Buttafly::Engine.routes.draw do
  resources :contents

  resources :mappings
  resources :spreadsheets

  root to: "contents#index"
end
