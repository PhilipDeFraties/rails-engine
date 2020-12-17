Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'items/find_all', to: 'items/search#index'
      get 'items/find', to: 'items/search#show'

      resources :items do
        get :merchants, to: 'items/merchants#show'
      end

      get 'merchants/find_all', to: 'merchants/search#index'
      get 'merchants/find', to: 'merchants/search#show'
      get 'merchants/most_revenue', to: 'merchants/bizintel#most_revenue'
      get 'merchants/most_items', to: 'merchants/bizintel#most_items'
      get '/merchants/:id/revenue', to: 'merchants/bizintel#revenue'
      get '/revenue', to: 'merchants/bizintel#revenue_across_dates'
      resources :merchants do
        get :items, to: 'merchants/items#index'
      end
    end
  end
end
