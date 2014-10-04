Buttafly::Engine.routes.draw do
  resources :contents

  resources :mappings
  resources :spreadsheets do 
    member do 
      get 'import'
      get 'process_file'
    end
  end

  root to: "contents#index"
end
