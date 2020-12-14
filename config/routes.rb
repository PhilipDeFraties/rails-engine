Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'items/find_all', to: 'items/search#index'

      resources :items do
        get :merchants, to: 'items/merchants#show'
      end
      
      resources :merchants do
        get :items, to: 'merchants/items#index'
      end
    end
  end
end
