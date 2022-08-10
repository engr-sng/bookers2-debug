Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  root to: "homes#top"
  get "home/about" => "homes#about"
  get "search" => "searches#search", as: "search"

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get "following" => "relationships#following", as: "following"
    get "follower" => "relationships#follower", as: "follower"
  end

  resources :rooms, only: [:index, :show, :create] do
    resources :messages, only: [:create]
    resources :room_enters, only: [:create]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
