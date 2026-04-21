# db/seeds.rb — Données de test initiales pour l'application
# Ce fichier permet de peupler la base de données avec des données de démonstration
# Exécuter avec : rails db:seed

# Nettoyage des données existantes pour éviter les doublons lors des re-seeds
puts "🧹 Nettoyage des données existantes..."

# Supprime d'abord les posts pour respecter les contraintes de clé étrangère
Post.destroy_all

# Supprime ensuite les utilisateurs
User.destroy_all

puts "👤 Création des utilisateurs..."

# Crée le premier utilisateur de démonstration
alice = User.create!(
  name: "Alice Dupont",
  email: "alice@example.com",
  password: "password123",
  password_confirmation: "password123"
)

# Crée le deuxième utilisateur de démonstration
bob = User.create!(
  name: "Bob Martin",
  email: "bob@example.com",
  password: "password123",
  password_confirmation: "password123"
)

# Crée un troisième utilisateur de démonstration
charlie = User.create!(
  name: "Charlie Lebrun",
  email: "charlie@example.com",
  password: "password123",
  password_confirmation: "password123"
)

puts "📰 Création des potins..."

# Crée des potins de démonstration associés aux utilisateurs
Post.create!([
  {
    title: "Le directeur arrive en skateboard !",
    content: "Incroyable mais vrai, hier matin notre directeur est arrivé au bureau en skateboard électrique. Les vigiles ne l'ont pas reconnu au début et ont failli lui refuser l'entrée. La scène était hilarante selon les témoins présents.",
    user: alice
  },
  {
    title: "Mystère à la machine à café",
    content: "Quelqu'un mange les sandwichs des autres dans le frigo de la salle de pause depuis deux semaines. Une note a été laissée ce matin : 'Je sais que c'est vous'. Le bureau est en effervescence.",
    user: bob
  },
  {
    title: "La réunion qui ne finissait plus",
    content: "La réunion de lundi prévue pour 30 minutes a duré 3 heures. Personne n'osait partir. À la fin, le chef a dit 'on refera ça la semaine prochaine'. Les visages étaient éloquents.",
    user: charlie
  },
  {
    title: "WiFi en panne = productivité record",
    content: "Paradoxalement, le jour où le WiFi est tombé en panne vendredi dernier, l'équipe a été plus productive que jamais. Tout le monde s'est mis à parler aux collègues en face à face. Étrange phénomène.",
    user: alice
  }
])

# Affiche un résumé des données créées
puts "✅ Seeds terminés !"
puts "   → #{User.count} utilisateurs créés"
puts "   → #{Post.count} potins créés"
puts ""
puts "📋 Comptes de test disponibles :"
puts "   Email: alice@example.com   | Mot de passe: password123"
puts "   Email: bob@example.com     | Mot de passe: password123"
puts "   Email: charlie@example.com | Mot de passe: password123"
