Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :artists, only: [:index, :create, :destroy]
      resources :albums, only: [:index, :create, :destroy]
      resources :favorite_artists, only: [:index, :create, :destroy]
      resources :favorite_albums, only: [:index, :create, :destroy]
    end
  end


end
