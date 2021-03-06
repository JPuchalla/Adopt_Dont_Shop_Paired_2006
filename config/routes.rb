Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'

  get '/shelters', to: 'shelters#index'
  get '/shelters/new', to: 'shelters#new'
  post '/shelters', to: 'shelters#create'
  get '/shelters/:id', to: 'shelters#show'
  get '/shelters/:id/edit', to: 'shelters#edit'
  patch '/shelters/:id', to: 'shelters#update'
  delete '/shelters/:id', to: 'shelters#destroy'

  get '/pets', to: 'pets#index'
  get '/pets/:id', to: 'pets#show'
  get '/pets/:id/edit', to: 'pets#edit'
  patch '/pets/:id', to: 'pets#update'
  delete '/pets/:id', to: 'pets#destroy'

  get '/shelters/:shelter_id/pets', to: 'shelter_pets#index'
  get '/shelters/:shelter_id/pets/new', to: 'shelter_pets#new'
  post '/shelters/:shelter_id/pets', to: 'shelter_pets#create'

  get '/shelters/:id/reviews/new', to: 'reviews#new'
  get '/shelters/:id/reviews/:review_id/edit', to: 'reviews#edit'
  patch '/shelters/:id/reviews/:review_id', to: 'reviews#update'
  delete '/shelters/:id/reviews/:review_id', to: 'reviews#destroy'
  post '/shelters/:id', to: 'reviews#create'

  get '/favorites', to: 'favorites#index'
  patch '/favorites/:pet_id', to: 'favorites#update'
  delete '/favorites/pets/:pet_id', to: 'favorites#show_destroy'
  delete '/favorites/:pet_id', to: 'favorites#index_destroy'
  delete '/favorites', to: 'favorites#destroy_all'

  get "/apps/new", to: 'apps#new'
  post "/apps", to: 'apps#create'
  get "/apps/:id", to: 'apps#show'

  get "/pets/:id/apps", to: 'pet_apps#index'
  patch '/apps/:app_id/pets/:pet_id/approve', to: 'pet_apps#approve'
  patch '/apps/:app_id/pets/:pet_id/revoke', to: 'pet_apps#revoke'
end
