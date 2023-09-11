Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"

  resources :pigeons, only: %i[index show create new ]
    patch "pigeons/:id/toggle_read", to: "pigeons#toggle_read", as: "toggle_read"
    patch "pigeons/:id/mark_read", to: "pigeons#mark_read", as: "mark_read"
    patch "pigeons/:id/link_read", to: "pigeons#link_read", as: "link_read"

  resources :chats, only: %i[new show create] do
    resources :messages, only: %i[ create]
  end
end
