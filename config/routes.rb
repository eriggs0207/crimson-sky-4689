Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
resources :chefs, only: [:show]
resources :dishes, only: [:show]
get '/chefs/:id/ingredients', to: 'ingredients#index'
end
