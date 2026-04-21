# 🗞️ The Big Project - Rails Auth & Cookies

> Application Rails de partage de potins avec système d'authentification complet (sessions + cookies "Se souvenir de moi") et déploiement Heroku.

---

## 📋 Table des matières

- [Présentation du projet](#présentation-du-projet)
- [Fonctionnalités](#fonctionnalités)
- [Technologies utilisées](#technologies-utilisées)
- [Prérequis](#prérequis)
- [Installation et exécution avec VS Code](#installation-et-exécution-avec-vs-code)
- [Extensions VS Code recommandées](#extensions-vs-code-recommandées)
- [Structure du projet](#structure-du-projet)
- [Déploiement sur Heroku](#déploiement-sur-heroku)
- [Comptes de test](#comptes-de-test)
- [Nom du repository GitHub](#nom-du-repository-github)

---

## 📖 Présentation du projet

**The Big Project** est une application web de partage de potins développée avec Ruby on Rails dans le cadre de la formation **ETP4A - Semaine 6, Jour 5**.

Ce projet est l'aboutissement d'une semaine de développement Rails. Il illustre les concepts fondamentaux de :
- L'authentification sécurisée avec BCrypt
- La gestion des sessions Rails
- Les cookies permanents avec système "Se souvenir de moi"
- La sécurité web (hachage des tokens, protection contre le session hijacking)
- Le déploiement en production sur Heroku

---

## ✨ Fonctionnalités

| Fonctionnalité | Description |
|---|---|
| 📝 Inscription | Création de compte avec validation email et mot de passe |
| 🔐 Connexion | Authentification sécurisée par email + mot de passe BCrypt |
| 🍪 Remember me | Cookies permanents (20 ans) pour rester connecté entre les sessions |
| 🔓 Déconnexion | Suppression des sessions ET des cookies + invalidation du digest en base |
| 🗞️ Potins | Publier, consulter et supprimer des potins |
| 👤 Profil | Page de profil avec la liste des potins d'un utilisateur |
| 🛡️ Protection | Routes protégées - création/suppression réservées aux utilisateurs connectés |

---

## 🛠️ Technologies utilisées

- **Ruby** 3.2.2
- **Rails** 7.1
- **SQLite3** (développement) / **PostgreSQL** (production Heroku)
- **BCrypt** - hachage sécurisé des mots de passe et tokens
- **Bootstrap 5** - framework CSS responsive
- **Puma** - serveur web
- **Heroku** - plateforme de déploiement (PaaS)

---

## ⚙️ Prérequis

Avant de lancer le projet, assurez-vous d'avoir installé :

- **Ruby** ≥ 3.2 - [Télécharger Ruby](https://www.ruby-lang.org/fr/downloads/)
- **Rails** ≥ 7.1 - `gem install rails`
- **Bundler** - `gem install bundler`
- **Git** - [Télécharger Git](https://git-scm.com/)
- **VS Code** - [Télécharger VS Code](https://code.visualstudio.com/)

> **Windows** : Utilisez [RubyInstaller](https://rubyinstaller.org/) pour installer Ruby facilement.

---

## 🚀 Installation et exécution avec VS Code

### Étape 1 - Cloner le repository

Ouvrez un terminal dans VS Code (`Ctrl+`` ` ou **Terminal > Nouveau terminal**) :

```bash
git clone https://github.com/VOTRE_USERNAME/rails-big-project-auth-cookies.git
cd rails-big-project-auth-cookies
```

### Étape 2 - Installer les dépendances Ruby (gems)

```bash
# Installe toutes les gems du Gemfile SAUF celles de production (pg)
# Évite les erreurs si PostgreSQL n'est pas installé sur votre machine
bundle install --without production
```

### Étape 3 - Créer et migrer la base de données

```bash
# Crée le fichier SQLite3 et applique toutes les migrations
rails db:create db:migrate
```

### Étape 4 - (Optionnel) Peupler la base avec des données de test

```bash
# Crée 3 utilisateurs et 4 potins de démonstration
rails db:seed
```

### Étape 5 - Lancer le serveur Rails

```bash
rails server
```

### Étape 6 - Ouvrir l'application dans le navigateur

Rendez-vous sur : **[http://localhost:3000](http://localhost:3000)**

---

## 🧩 Extensions VS Code recommandées

Installez ces extensions avant de travailler sur le projet pour une meilleure expérience de développement.

### Extensions obligatoires

| Extension | ID | Utilité |
|---|---|---|
| **Ruby LSP** | `Shopify.ruby-lsp` | Autocomplétion, navigation dans le code Ruby, diagnostics en temps réel |
| **ERB Formatter/Beautify** | `aliariff.vscode-erb-beautify` | Formatage automatique des fichiers `.html.erb` |
| **Rails** | `bung787.ruby-rails-vscode` | Snippets Rails, navigation entre MVC (model/view/controller) |
| **GitLens** | `eamodio.gitlens` | Visualisation de l'historique Git, annotations de blame |

### Extensions fortement recommandées

| Extension | ID | Utilité |
|---|---|---|
| **endwise** | `kaiwood.endwise` | Complète automatiquement les blocs `end` en Ruby |
| **Prettier** | `esbenp.prettier-vscode` | Formatage du CSS, JSON, Markdown |
| **SQLite Viewer** | `qwtel.sqlite-viewer` | Visualise les données SQLite directement dans VS Code |
| **DotENV** | `mikestead.dotenv` | Coloration syntaxique des fichiers `.env` |
| **Auto Rename Tag** | `formulahendry.auto-rename-tag` | Renomme automatiquement les balises HTML/ERB en paire |

### Installation rapide de toutes les extensions

Copiez-collez cette commande dans le terminal VS Code pour tout installer d'un coup :

```bash
code --install-extension Shopify.ruby-lsp
code --install-extension aliariff.vscode-erb-beautify
code --install-extension bung787.ruby-rails-vscode
code --install-extension eamodio.gitlens
code --install-extension kaiwood.endwise
code --install-extension esbenp.prettier-vscode
code --install-extension qwtel.sqlite-viewer
code --install-extension mikestead.dotenv
code --install-extension formulahendry.auto-rename-tag
```

---

## 📁 Structure du projet

```
the-big-project/
│
├── app/
│   ├── controllers/
│   │   ├── application_controller.rb   # Controller de base (require_login)
│   │   ├── sessions_controller.rb      # Login / Logout
│   │   ├── users_controller.rb         # Inscription / Profil
│   │   └── posts_controller.rb         # CRUD des potins
│   │
│   ├── helpers/
│   │   └── sessions_helper.rb          # ⭐ Logique d'auth : sessions + cookies
│   │
│   ├── models/
│   │   ├── user.rb                     # Modèle User (BCrypt, validations, remember)
│   │   └── post.rb                     # Modèle Post (validations, associations)
│   │
│   ├── views/
│   │   ├── layouts/
│   │   │   └── application.html.erb   # Layout partagé (navbar, flash, footer)
│   │   ├── sessions/
│   │   │   └── new.html.erb           # Formulaire de connexion
│   │   ├── users/
│   │   │   ├── new.html.erb           # Formulaire d'inscription
│   │   │   └── show.html.erb          # Page de profil
│   │   └── posts/
│   │       ├── index.html.erb         # Liste des potins (page d'accueil)
│   │       ├── new.html.erb           # Formulaire de publication
│   │       └── show.html.erb          # Détail d'un potin
│   │
│   └── assets/
│       └── stylesheets/
│           └── application.scss       # Styles Bootstrap + personnalisés
│
├── config/
│   ├── routes.rb                       # Définition des routes URL
│   └── database.yml                    # Configuration SQLite3 / PostgreSQL
│
├── db/
│   ├── migrate/
│   │   ├── 20240101000001_create_users.rb    # Migration table users
│   │   └── 20240101000002_create_posts.rb    # Migration table posts
│   └── seeds.rb                              # Données de test initiales
│
├── Gemfile                             # Dépendances Ruby (gems)
├── Procfile                            # Configuration du processus Heroku
├── .gitignore                          # Fichiers exclus de Git
└── README.md                           # Ce fichier
```

---

## ☁️ Déploiement sur Heroku

### Prérequis Heroku

1. Créer un compte sur [heroku.com](https://heroku.com)
2. Installer la CLI Heroku : [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli)
3. Se connecter : `heroku login`

### Étapes de déploiement

```bash
# 1. Initialiser Git si pas encore fait
git init
git add .
git commit -m "Initial commit"

# 2. Créer l'application Heroku (choisir un nom unique)
heroku create rails-big-project-auth-cookies

# 3. Déployer sur Heroku
git push heroku main

# 4. Exécuter les migrations sur Heroku (OBLIGATOIRE si migrations)
heroku run rails db:migrate

# 5. (Optionnel) Ajouter les données de seed en production
heroku run rails db:seed

# 6. Ouvrir l'application dans le navigateur
heroku open
```

### En cas d'erreur sur Heroku

```bash
# Consulter les logs d'erreur en temps réel
heroku logs --tail

# Relancer l'application si elle est bloquée
heroku restart
```

> ⚠️ **Important** : Le Gemfile est déjà configuré pour utiliser SQLite3 en développement et PostgreSQL en production. Aucune modification n'est nécessaire.

---

## 🧪 Comptes de test

Après `rails db:seed`, les comptes suivants sont disponibles :

| Nom | Email | Mot de passe |
|---|---|---|
| Alice Dupont | alice@example.com | password123 |
| Bob Martin | bob@example.com | password123 |
| Charlie Lebrun | charlie@example.com | password123 |

---

## 📦 Nom du repository GitHub

**Nom recommandé** : `rails-big-project-auth-cookies`

Ce nom est :
- ✅ Descriptif (Rails + Big Project + Auth + Cookies)
- ✅ En kebab-case (convention GitHub)
- ✅ Court et mémorable
- ✅ Reflète fidèlement le contenu du projet



## 📚 Ressources utiles

- [Documentation officielle Rails](https://guides.rubyonrails.org/)
- [Heroku - Getting Started with Rails](https://devcenter.heroku.com/articles/getting-started-with-rails7)
- [The Odin Project - Sessions & Cookies](https://www.theodinproject.com/)
- [Grafikart - Sessions et Cookies](https://grafikart.fr/)
