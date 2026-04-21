# app/models/user.rb — Modèle User (utilisateur)
# Ce modèle représente un utilisateur de l'application
# Il gère l'authentification par mot de passe et le système de cookies "remember me"

class User < ApplicationRecord
  # has_secure_password : méthode Rails qui active l'authentification sécurisée
  # Elle nécessite une colonne 'password_digest' en base de données
  # Elle fournit automatiquement les méthodes authenticate, password=, password_confirmation=
  # Elle utilise BCrypt pour hasher les mots de passe en base
  has_secure_password

  # Association : un utilisateur peut avoir plusieurs posts (potins)
  # dependent: :destroy supprime tous les posts si l'utilisateur est supprimé
  has_many :posts, dependent: :destroy

  # Validation : l'email est obligatoire et doit être unique (pas deux comptes avec le même email)
  validates :email, presence: true, uniqueness: true

  # Validation : l'email doit correspondre au format standard d'une adresse email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Validation : le nom est obligatoire
  validates :name, presence: true

  # Validation : le mot de passe doit faire au moins 6 caractères
  validates :password, length: { minimum: 6 }, allow_nil: true

  # Callback : convertit l'email en minuscules avant de sauvegarder en base
  # Cela évite les problèmes de casse (ex: "User@Email.com" et "user@email.com" seraient deux comptes différents)
  before_save { self.email = email.downcase }

  # ============================================================
  # Méthode d'instance : remember(remember_token)
  # Permet de stocker en base le hash sécurisé du remember_token
  # Appelée depuis le helper sessions_helper.rb lors du remember(user)
  # ============================================================
  def remember(remember_token)
    # Génère un hash BCrypt sécurisé à partir du remember_token fourni
    # BCrypt::Password.create() transforme un string en hash irréversible
    remember_digest = BCrypt::Password.create(remember_token)

    # Sauvegarde le digest hashé dans la colonne remember_digest de la base de données
    # Note: on ne stocke JAMAIS le token en clair — seulement son hash
    update(remember_digest: remember_digest)
  end

  # ============================================================
  # Méthode d'instance : forget
  # Efface le remember_digest en base lors de la déconnexion
  # Invalide tous les cookies existants de l'utilisateur
  # ============================================================
  def forget
    # Remet remember_digest à nil pour invalider le cookie côté serveur
    # Même si le cookie existe encore dans le navigateur, il ne sera plus valide
    update(remember_digest: nil)
  end
end
