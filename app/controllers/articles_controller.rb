class ArticlesController < ApplicationController
  before_action :require_user_logged_in, except: [:show, :likes]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def show
    @article = Article.find_by(id: params[:id])
    @user = @article.user
    counts(@article)
    @comment = Comment.new
    @comments = @article.comments.order(id: :desc)
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:success] = '新しい記事を作成しました'
      redirect_to user_url(@article.user)
    else
      flash.now[:danger] = '記事の作成に失敗しました'
      render :new
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = "記事を更新しました"
      redirect_to root_url
    else
      flash.now[:danger] = '記事を更新できませんでした'
      render :edit
    end
  end

  def destroy
    @article.destroy
    flash[:success] = '記事を削除しました'
    redirect_to root_url
  end
  
  def likes
    @article = Article.find(params[:id])
    @users = @article.users.page(params[:page])
    counts(@article)
  end
  
  def comments
    @article = Article.find_by(id: params[:id])
    @comment = Comment.new
    @comments = @article.comments.order(id: :desc)
  end
  
  private
  
  # ストロングパラメータ
  def article_params
    params.require(:article).permit(:title, :article, :title_image, :article_image)
  end
  
  def correct_user
    @article = current_user.articles.find_by(id: params[:id])
    unless @article
      redirect_to root_url
    end
  end
  
  def counts(article)
      @count_liked_article = article.users.count  # 記事をいいねしたユーザーの数
  end
end
