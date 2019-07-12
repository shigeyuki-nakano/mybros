class FavoritesController < ApplicationController
  def create
    article = Article.find(params[:article_id])
    current_user.like(article)
    flash[:success] = 'いいねしました'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    article = Article.find(params[:article_id])
    current_user.unlike(article)
    redirect_back(fallback_location: root_path)
  end
end
