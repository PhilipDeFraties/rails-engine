Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'items/find_all', to: 'items/search#index'
      get 'items/find', to: 'items/search#show'

      resources :items do
        get :merchants, to: 'items/merchants#show'
      end
      namespace :merchants do
        get 'find_all', to: 'search#index'
        get 'find', to: 'search#show'
        get 'most_revenue', to: 'bizintel#most_revenue'
        get 'most_items', to: 'bizintel#most_items'
        get ':id/revenue', to: 'bizintel#revenue'
      end

      get '/revenue', to: 'merchants/bizintel#revenue_across_dates'

      resources :merchants do
        get :items, to: 'merchants/items#index'
      end
    end
  end
end
