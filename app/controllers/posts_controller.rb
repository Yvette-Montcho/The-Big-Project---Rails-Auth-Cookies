# app/controllers/posts_controller.rb — Controller de gestion des posts (potins)
# Gère la liste, la création et la suppression des potins de l'application

class PostsController < ApplicationController
  # before_action : exécute require_login avant les actions new, create et destroy
  # Empêche les utilisateurs non connectés de créer ou supprimer des potins
  before_action :require_login, only: [:new, :create, :destroy]

  # before_action : vérifie que l'utilisateur est l'auteur du post avant de le supprimer
  before_action :correct_user, only: [:destroy]

  # ============================================================
  # index — Affiche la liste de tous les potins
  # GET /posts (et GET /)
  # ============================================================
  def index
    # Récupère tous les posts avec leur auteur (include évite le problème N+1 queries)
    # :recent est le scope défini dans le modèle Post (ordre chronologique inverse)
    @posts = Post.includes(:user).recent
  end

  # ============================================================
  # show — Affiche le détail d'un potin
  # GET /posts/:id
  # ============================================================
  def show
    # Trouve le post par son ID passé dans l'URL
    @post = Post.find(params[:id])
  end

  # ============================================================
  # new — Affiche le formulaire de création d'un potin
  # GET /posts/new
  # ============================================================
  def new
    # Crée un objet Post vide pour le formulaire
    @post = Post.new
  end

  # ============================================================
  # create — Traite la soumission du formulaire de création
  # POST /posts
  # ============================================================
  def create
    # Crée un nouveau post avec les paramètres filtrés
    @post = Post.new(post_params)

    # Associe le post à l'utilisateur actuellement connecté
    # current_user est défini dans sessions_helper.rb
    @post.user = current_user

    # Tente de sauvegarder le post en base de données
    if @post.save
      # Affiche un message de succès dans le flash
      flash[:notice] = 'Votre potin a été publié !'

      # Redirige vers la liste des posts
      redirect_to posts_path
    else
      # La sauvegarde a échoué — réaffiche le formulaire avec les erreurs
      render :new, status: :unprocessable_entity
    end
  end

  # ============================================================
  # destroy — Supprime un potin
  # DELETE /posts/:id
  # ============================================================
  def destroy
    # Supprime le post de la base de données
    @post.destroy

    # Affiche un message de confirmation
    flash[:notice] = 'Votre potin a été supprimé.'

    # Redirige vers la liste des posts
    redirect_to posts_path
  end

  # ============================================================
  # Private : méthodes internes du controller
  # ============================================================
  private

  # Filtre les paramètres autorisés pour la création d'un post
  def post_params
    # Seuls :title et :content sont acceptés — empêche l'injection de champs malveillants
    params.require(:post).permit(:title, :content)
  end

  # Vérifie que l'utilisateur connecté est bien l'auteur du post
  # Empêche un utilisateur de supprimer les posts d'un autre
  def correct_user
    # Trouve le post à supprimer
    @post = current_user.posts.find_by(id: params[:id])

    # Redirige vers l'accueil si le post n'appartient pas à l'utilisateur connecté
    redirect_to root_path, alert: 'Accès non autorisé.' if @post.nil?
  end
end
