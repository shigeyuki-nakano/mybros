class FavoritesController < ApplicationController
  def create
    article = Article.find(params[:article_id])
    current_user.like(article)
    flash[:success] = 'お気に入りに登録しました'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    article = Article.find(params[:article_id])
    current_user.unlike(article)
    flash[:success] = 'お気に入りを解除しました'
    redirect_back(fallback_location: root_path)
  end
end
