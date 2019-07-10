class ArticlesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def show
    @article = Article.find(params[:id])
    @user = @article.user
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:success] = '新しい記事を作成しました'
      redirect_to root_url
    else
      @ariticles = current_user.articles.order(id: :desc).page(params[:page])
      flash.now[:danger] = '記事の作成に失敗しました'
      render 'toppages/index'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @article.destroy
    flash[:success] = '記事を削除しました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def article_params
    params.require(:article).permit(:title, :article, :title_image, :article_image)
  end
  
  def correct_user
    @article = current_user.articles.find_by(id: params[:id])
    unless @article
      redirect_to root_url
    end
  end
end
