# config/routes.rb — Fichier de configuration des routes de l'application
# Les routes définissent les URLs disponibles et les actions de controller associées

Rails.application.routes.draw do
  # Route racine : page d'accueil de l'application (posts#index)
  # Accessible via GET /
  root 'posts#index'

  # Routes pour la gestion des sessions (login / logout)
  # GET  /login  → sessions#new    (affiche le formulaire de connexion)
  # POST /login  → sessions#create (traite la connexion de l'utilisateur)
  # DELETE /logout → sessions#destroy (déconnecte l'utilisateur)
  get    '/login',  to: 'sessions#new',     as: :login
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: :logout

  # Routes REST complètes pour les utilisateurs
  # GET    /users/new     → users#new    (formulaire d'inscription)
  # POST   /users         → users#create (crée un nouveau compte)
  # GET    /users/:id     → users#show   (profil de l'utilisateur)
  resources :users, only: [:new, :create, :show]

  # Routes REST complètes pour les posts (potins)
  # GET    /posts         → posts#index  (liste tous les potins)
  # GET    /posts/new     → posts#new    (formulaire de nouveau potin)
  # POST   /posts         → posts#create (crée un nouveau potin)
  # GET    /posts/:id     → posts#show   (détail d'un potin)
  # DELETE /posts/:id     → posts#destroy (supprime un potin)
  resources :posts, only: [:index, :new, :create, :show, :destroy]
end
