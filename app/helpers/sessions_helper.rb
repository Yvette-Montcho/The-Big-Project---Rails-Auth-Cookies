# app/helpers/sessions_helper.rb — Helper de gestion des sessions et cookies
# Ce helper centralise toute la logique d'authentification de l'application
# Il est inclus automatiquement dans ApplicationController (via include SessionsHelper)

module SessionsHelper
  # ============================================================
  # log_in(user) — Connecte l'utilisateur via une SESSION temporaire
  # La session est détruite dès que le navigateur est fermé
  # ============================================================
  def log_in(user)
    # Stocke l'ID de l'utilisateur dans la session chiffrée de Rails
    # La session est signée par une clé secrète — impossible à falsifier côté client
    session[:user_id] = user.id
  end

  # ============================================================
  # remember(user) — Connecte l'utilisateur via des COOKIES permanents
  # Les cookies persistent même après fermeture du navigateur (20 ans)
  # ============================================================
  def remember(user)
    # Génère un token aléatoire sécurisé avec SecureRandom.urlsafe_base64
    # Exemple de valeur générée : "MPQWxQ4K1gYpfJ9f1v0KAA"
    # Ce token sera stocké en clair dans le cookie du navigateur
    remember_token = SecureRandom.urlsafe_base64

    # Appelle la méthode d'instance remember du modèle User
    # Stocke en base de données le HASH du token (jamais le token en clair)
    user.remember(remember_token)

    # Crée un cookie permanent (expire dans 20 ans) stockant l'ID de l'utilisateur
    # Permet de retrouver l'utilisateur en base lors des prochaines visites
    cookies.permanent[:user_id] = user.id

    # Crée un cookie permanent stockant le remember_token en clair
    # Ce token sera comparé avec le hash stocké en base pour valider l'identité
    cookies.permanent[:remember_token] = remember_token
  end

  # ============================================================
  # current_user — Retourne l'utilisateur actuellement connecté
  # Vérifie d'abord la session, puis les cookies si pas de session
  # ============================================================
  def current_user
    # Vérifie si une session active existe (connexion normale ou cookie récent)
    if session[:user_id]
      # Trouve l'utilisateur grâce à l'ID stocké dans la session
      # find_by retourne nil si l'utilisateur n'existe pas (ne lève pas d'erreur)
      @current_user ||= User.find_by(id: session[:user_id])

    # Si pas de session, vérifie si un cookie d'identification existe
    elsif cookies[:user_id]
      # Trouve l'utilisateur grâce à l'ID stocké dans le cookie
      user = User.find_by(id: cookies[:user_id])

      # Vérifie que l'utilisateur existe et que le token du cookie est valide
      if user && BCrypt::Password.new(user.remember_digest).is_password?(cookies[:remember_token])
        # Le cookie est valide — crée une session pour éviter de revérifier à chaque page
        log_in(user)
        # Assigne l'utilisateur à la variable d'instance pour le reste de la requête
        @current_user = user
      end
    end
  end

  # ============================================================
  # logged_in? — Indique si un utilisateur est actuellement connecté
  # Retourne true si connecté, false sinon
  # ============================================================
  def logged_in?
    # current_user retourne nil si personne n'est connecté
    # .present? retourne false si la valeur est nil ou vide
    current_user.present?
  end

  # ============================================================
  # forget(user) — Supprime les cookies de l'utilisateur
  # Appelée lors de la déconnexion pour invalider le "remember me"
  # ============================================================
  def forget(user)
    # Remet le remember_digest à nil en base de données
    # Le cookie existant dans le navigateur devient ainsi invalide
    user.forget

    # Supprime le cookie contenant l'ID de l'utilisateur du navigateur
    cookies.delete(:user_id)

    # Supprime le cookie contenant le remember_token du navigateur
    cookies.delete(:remember_token)
  end

  # ============================================================
  # log_out(user) — Déconnecte complètement l'utilisateur
  # Supprime la session ET les cookies
  # ============================================================
  def log_out(user)
    # Supprime l'ID utilisateur de la session Rails
    session.delete(:user_id)

    # Réinitialise la variable d'instance current_user
    @current_user = nil

    # Supprime les cookies permanents et invalide le digest en base
    forget(user)
  end
end
