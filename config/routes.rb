Buttafly::Engine.routes.draw do

  resources :legends
  resources :mappings
  resources :contents do
    member do 
      patch 'archive'
      patch 'replicate'
    end
  end

  root to: "contents#index"
end
