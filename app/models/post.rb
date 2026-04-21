# app/models/post.rb — Modèle Post (potin/ragot)
# Ce modèle représente un potin publié par un utilisateur sur l'application
# Un post appartient à un utilisateur et contient un titre et un contenu

class Post < ApplicationRecord
  # Association : un post appartient à un utilisateur
  # Cette association rend obligatoire la présence d'un user_id valide en base
  belongs_to :user

  # Validation : le titre du potin est obligatoire et ne peut pas être vide
  validates :title, presence: true

  # Validation : le contenu du potin est obligatoire et ne peut pas être vide
  validates :content, presence: true

  # Validation : le titre doit faire au minimum 3 caractères pour être significatif
  validates :title, length: { minimum: 3 }

  # Validation : le contenu doit faire au minimum 10 caractères pour être substantiel
  validates :content, length: { minimum: 10 }

  # Scope : retourne les posts triés du plus récent au plus ancien
  # Utilisé dans les vues pour afficher les derniers potins en premier
  scope :recent, -> { order(created_at: :desc) }
end
