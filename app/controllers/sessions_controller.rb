# app/controllers/sessions_controller.rb — Controller de gestion des sessions
# Gère la connexion (login) et la déconnexion (logout) des utilisateurs
# Les sessions sont stockées côté serveur, les cookies côté navigateur

class SessionsController < ApplicationController
  # ============================================================
  # new — Affiche le formulaire de connexion
  # GET /login
  # ============================================================
  def new
    # Redirige vers l'accueil si l'utilisateur est déjà connecté
    # Évite d'afficher le formulaire de login à quelqu'un déjà authentifié
    redirect_to root_path if logged_in?
  end

  # ============================================================
  # create — Traite la soumission du formulaire de connexion
  # POST /login
  # ============================================================
  def create
    # Recherche l'utilisateur par son email (converti en minuscules pour cohérence)
    # find_by retourne nil si l'email n'est pas trouvé en base
    user = User.find_by(email: params[:session][:email].downcase)

    # Vérifie que l'utilisateur existe ET que le mot de passe est correct
    # user.authenticate() est fourni par has_secure_password — compare le mot de passe avec le hash BCrypt
    if user && user.authenticate(params[:session][:password])
      # Connecte l'utilisateur via une session Rails (valable jusqu'à fermeture du navigateur)
      log_in(user)

      # Vérifie si la checkbox "Se souvenir de moi" a été cochée
      # params[:session][:remember_me] contient "1" si cochée, "0" sinon
      if params[:session][:remember_me] == '1'
        # L'utilisateur veut rester connecté — crée des cookies permanents (20 ans)
        remember(user)
      end

      # Affiche un message de bienvenue dans le flash
      flash[:notice] = "Bienvenue #{user.name} !"

      # Redirige vers la page d'accueil après connexion réussie
      redirect_to root_path
    else
      # Authentification échouée — affiche un message d'erreur
      # flash.now est utilisé pour afficher le message uniquement sur le render suivant
      flash.now[:alert] = 'Email ou mot de passe incorrect.'

      # Réaffiche le formulaire de connexion avec le message d'erreur
      render :new, status: :unprocessable_entity
    end
  end

  # ============================================================
  # destroy — Déconnecte l'utilisateur
  # DELETE /logout
  # ============================================================
  def destroy
    # Déconnecte l'utilisateur seulement s'il est bien connecté
    # Évite les erreurs si quelqu'un appelle /logout sans être connecté
    if logged_in?
      # Supprime la session ET les cookies permanents + invalide le digest en base
      log_out(current_user)
    end

    # Affiche un message de confirmation de déconnexion
    flash[:notice] = 'Vous avez été déconnecté.'

    # Redirige vers la page d'accueil après déconnexion
    redirect_to root_path
  end
end
