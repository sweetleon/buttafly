Buttafly::Engine.routes.draw do

  resources :legends
  resources :mappings
  resources :contents do
    member do 
      patch 'archive'
      patch 'import'
      patch 'transmogrify'
    end
  end

  root to: "contents#index"
end
