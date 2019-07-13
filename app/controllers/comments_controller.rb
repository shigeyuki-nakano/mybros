class CommentsController < ApplicationController
  before_action :correct_user, only: [:destroy]
  
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user if current_user
    
    if @comment.save
      flash[:success] = "#{@article.title}にコメントしました"
      redirect_to article_path(@article)
    else
      flash[:danger] = "コメントできませんでした"
      redirect_back(fallback_location: root_url)
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "コメントを削除しました"
    redirect_to root_url
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:name, :content)
  end
  
  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    unless @comment
      redirect_to root_url
    end
  end
end
