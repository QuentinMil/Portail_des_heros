Rails.application.routes.draw do
  get 'posts/index'
  get 'posts/show'
  devise_for :users
  root to: "pages#home"


  # Les routes pour notre lexique (Post)
  resources :posts, only: [:index, :show]
  
  #routes vers les tutos
  resources :universes do
    member do
      get :tutorials
    end
  end
  
  resources :tutorials, only: [:index]
end
