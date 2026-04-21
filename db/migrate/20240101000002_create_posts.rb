# db/migrate/20240101000002_create_posts.rb — Migration : création de la table posts
# Cette migration crée la table des potins avec une clé étrangère vers les utilisateurs
# Exécuter avec : rails db:migrate

class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    # Crée la table 'posts' pour stocker les potins des utilisateurs
    create_table :posts do |t|
      # Colonne title : titre du potin (obligatoire)
      t.string :title, null: false

      # Colonne content : texte complet du potin (obligatoire)
      # :text est utilisé pour les contenus longs (contrairement à :string limité à 255 chars)
      t.text :content, null: false

      # Clé étrangère vers la table users
      # Chaque potin est associé à un utilisateur (auteur)
      # null: false : impossible de créer un potin sans auteur
      # foreign_key: true : contrainte d'intégrité référentielle en base
      t.references :user, null: false, foreign_key: true

      # Ajoute automatiquement les colonnes created_at et updated_at
      t.timestamps
    end
  end
end
