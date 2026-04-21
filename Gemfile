# Gemfile — Fichier de déclaration de toutes les gems (bibliothèques) du projet Rails
# Chaque gem est un module Ruby qui ajoute des fonctionnalités à l'application

# Définit la source officielle depuis laquelle RubyGems télécharge les gems
source 'https://rubygems.org'

# Version minimale de Ruby requise pour faire tourner l'application
ruby '3.2.2'

# Rails : le framework principal de l'application — fournit MVC, routes, ORM, etc.
gem 'rails', '~> 7.1.0'

# Puma : serveur web performant utilisé en développement et en production
gem 'puma', '>= 5.0'

# Sprockets : gère l'asset pipeline (CSS, JS, images)
gem 'sprockets-rails'

# Importmap : permet d'importer des modules JavaScript modernes sans bundler
gem 'importmap-rails'

# Turbo-Rails : accélère la navigation en évitant les rechargements de page entiers
gem 'turbo-rails'

# Stimulus-Rails : framework JavaScript léger pour ajouter du comportement aux vues
gem 'stimulus-rails'

# Jbuilder : gem pour construire des réponses JSON dans les vues
gem 'jbuilder'

# BCrypt : bibliothèque de hachage sécurisé des mots de passe et tokens
# Utilisé par has_secure_password et pour hasher les remember_tokens
gem 'bcrypt', '~> 3.1.7'

# Tzinfo-data : données de fuseaux horaires pour Windows et JRuby
gem 'tzinfo-data', platforms: %i[windows jruby]

# Bootsnap : accélère le démarrage de l'application en mettant en cache les fichiers
gem 'bootsnap', require: false

# Bootstrap : framework CSS pour une interface utilisateur responsive et moderne
gem 'bootstrap', '~> 5.3.0'

# Sassc-Rails : permet d'utiliser SASS/SCSS dans les feuilles de style
gem 'sassc-rails'

# ============================================================
# Groupe DEVELOPMENT & TEST : gems utilisées uniquement en local
# Ces gems ne seront PAS installées sur Heroku (production)
# ============================================================
group :development, :test do
  # SQLite3 : base de données légère utilisée en développement et en test
  # Simple à utiliser, ne nécessite pas d'installation supplémentaire
  gem 'sqlite3', '~> 1.4'

  # Debug : gem de débogage intégrée à Rails 7
  gem 'debug', platforms: %i[mri windows]
end

# ============================================================
# Groupe DEVELOPMENT : gems utilisées uniquement en développement
# ============================================================
group :development do
  # Web-console : affiche une console interactive dans le navigateur en cas d'erreur
  gem 'web-console'
end

# ============================================================
# Groupe PRODUCTION : gems utilisées uniquement sur Heroku
# Heroku utilise PostgreSQL et non SQLite3
# ============================================================
group :production do
  # pg : adapter PostgreSQL pour Active Record — requis obligatoirement par Heroku
  gem 'pg', '>= 0.18'
end
