Rails.application.routes.draw do

  devise_for :users
  root to: "pages#home"

  # A FAIRE : Limiter le nombre de routes pour des questions de sécurité
  # création d'une route pour afficher tous les personnages créés sur le serveur
  resources :characters as: 'mes_personnages' do
    collection do
      get 'all', to: 'characters#all_characters', as: 'tous_les_personnages'
    end
  end

  # Les routes pour notre lexique (Post)
  resources :posts, only: [:index, :show]

  #routes vers les tutos
  resources :universes do
    member do
      get :tutorials
    end
  end

  # list des tutos
  resources :tutorials, only: [:index]
end
