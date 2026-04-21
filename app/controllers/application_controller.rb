# app/controllers/application_controller.rb — Controller de base de l'application
# Tous les autres controllers héritent de ce controller
# C'est ici qu'on place les méthodes utiles dans toute l'application

class ApplicationController < ActionController::Base
  # Inclut le module SessionsHelper dans tous les controllers
  # Cela rend disponibles les méthodes : log_in, log_out, current_user, logged_in?, etc.
  include SessionsHelper

  # ============================================================
  # require_login — Méthode de protection des routes privées
  # Redirige vers la page de login si l'utilisateur n'est pas connecté
  # Utilisée avec before_action dans les controllers concernés
  # ============================================================
  def require_login
    # Vérifie si un utilisateur est connecté (session ou cookie valide)
    unless logged_in?
      # Affiche un message d'alerte dans le flash
      flash[:alert] = 'Vous devez être connecté pour accéder à cette page.'

      # Redirige vers la page de connexion
      redirect_to login_path
    end
  end
end
