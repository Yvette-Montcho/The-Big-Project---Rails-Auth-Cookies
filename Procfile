# Procfile - Fichier de configuration des processus Heroku
# Heroku lit ce fichier pour savoir quelle commande lancer pour démarrer l'application
# La ligne 'web' définit le processus web (serveur HTTP)

# Lance le serveur Puma sur le port fourni par Heroku via la variable d'environnement $PORT
# -C config/puma.rb : utilise le fichier de configuration Puma spécifique à la production
web: bundle exec puma -C config/puma.rb
