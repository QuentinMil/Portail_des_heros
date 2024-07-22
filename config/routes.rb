Rails.application.routes.draw do

  devise_for :users
  root to: "pages#home"

  # A FAIRE : Limiter le nombre de routes pour des questions de sécurité
  resources :characters, path: 'mes_personnages'
  resources :parties, path: 'mes_parties'

  # création d'une route pour afficher tous les personnages créés sur le serveur
  get '/tous_les_personnages', to: 'characters#all_characters', as: 'tous_les_personnages'


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
