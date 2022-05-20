Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'lists#index'
  # Defines the root path route ("/")
  # root "articles#index"
  resources :lists, only: %i[index new create show update] do
    resources :bookmarks, only: %i[index new show edit create update]
  end
  resources :bookmarks, only: %i[destroy]
end
