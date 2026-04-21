# db/migrate/20240101000001_create_users.rb — Migration : création de la table users
# Cette migration crée la table des utilisateurs avec toutes les colonnes nécessaires
# Exécuter avec : rails db:migrate

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    # Crée la table 'users' en base de données
    # Rails ajoute automatiquement les colonnes id (clé primaire), created_at et updated_at
    create_table :users do |t|
      # Colonne name : prénom et nom de l'utilisateur (obligatoire)
      t.string :name, null: false

      # Colonne email : adresse email unique de l'utilisateur (obligatoire)
      # Utilisée pour la connexion — null: false interdit les valeurs vides en base
      t.string :email, null: false

      # Colonne password_digest : hash BCrypt du mot de passe
      # Requise par has_secure_password dans le modèle User
      # Le mot de passe en clair n'est JAMAIS stocké en base
      t.string :password_digest, null: false

      # Colonne remember_digest : hash BCrypt du remember_token pour les cookies
      # Vide par défaut — remplie lors de l'activation du "Se souvenir de moi"
      # Remise à nil lors de la déconnexion pour invalider le cookie
      t.string :remember_digest

      # Ajoute automatiquement les colonnes created_at et updated_at
      t.timestamps
    end

    # Ajoute un index unique sur la colonne email
    # Garantit qu'il ne peut pas y avoir deux utilisateurs avec le même email
    # Améliore aussi les performances des requêtes de recherche par email
    add_index :users, :email, unique: true
  end
end
