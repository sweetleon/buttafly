Buttafly::Engine.routes.draw do

  resources :legends
  resources :mappings
  resources :contents do
    member do 
      get 'import'
      get 'publish'
    end
  end

  root to: "contents#index"
end
