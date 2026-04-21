# app/controllers/users_controller.rb — Controller de gestion des utilisateurs
# Gère l'inscription (signup) et l'affichage des profils utilisateurs

class UsersController < ApplicationController
  # ============================================================
  # new — Affiche le formulaire d'inscription
  # GET /users/new
  # ============================================================
  def new
    # Redirige vers l'accueil si l'utilisateur est déjà connecté
    redirect_to root_path if logged_in?

    # Crée un nouvel objet User vide pour le formulaire
    # Ce @user sera utilisé dans la vue via form_with(model: @user)
    @user = User.new
  end

  # ============================================================
  # create — Traite la soumission du formulaire d'inscription
  # POST /users
  # ============================================================
  def create
    # Crée un nouvel utilisateur avec les paramètres filtrés (strong parameters)
    # user_params interdit les paramètres non autorisés pour sécuriser l'application
    @user = User.new(user_params)

    # Tente de sauvegarder l'utilisateur en base de données
    if @user.save
      # Inscription réussie — connecte automatiquement le nouvel utilisateur
      # Crée une session sans avoir besoin de se reconnecter
      log_in(@user)

      # Vérifie si la checkbox "Se souvenir de moi" a été cochée à l'inscription
      if params[:user][:remember_me] == '1'
        # L'utilisateur veut rester connecté — crée des cookies permanents (20 ans)
        remember(@user)
      end

      # Affiche un message de bienvenue pour le nouvel utilisateur
      flash[:notice] = "Bienvenue #{@user.name} ! Votre compte a été créé avec succès."

      # Redirige vers la page d'accueil après inscription réussie
      redirect_to root_path
    else
      # La sauvegarde a échoué (validations non respectées)
      # Les erreurs sont disponibles dans @user.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  # ============================================================
  # show — Affiche le profil d'un utilisateur
  # GET /users/:id
  # ============================================================
  def show
    # Trouve l'utilisateur par son ID dans l'URL (params[:id])
    # find lève une erreur ActiveRecord::RecordNotFound si l'ID n'existe pas
    @user = User.find(params[:id])

    # Récupère les posts de cet utilisateur triés du plus récent au plus ancien
    @posts = @user.posts.recent
  end

  # ============================================================
  # Private : strong parameters pour la sécurité
  # Seuls les champs autorisés peuvent être assignés en masse
  # ============================================================
  private

  def user_params
    # Autorise uniquement les paramètres nécessaires à la création d'un utilisateur
    # :password_confirmation permet de vérifier que les deux mots de passe correspondent
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
