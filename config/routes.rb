Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"

  resources :pigeons, only: %i[index show create new edit update destroy]
    patch "pigeons/:id/unmark_read", to: "pigeons#unmark_read", as: "unmark_read"
    # patch "pigeons/:id/mark_read", to: "pigeons#mark_read"

  resources :chats, only: %i[new show create] do
    resources :messages, only: %i[ create]
  end

  resources :users, only: [:index]
end
