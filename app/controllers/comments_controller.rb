class CommentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_comment, only: [:destroy]
  before_action :correct_user, only: [:destroy]
  
  def create
    @comment = current_user.comments.build(comment_params)
    post = Post.find_by(id: params[:post_id])
    if @comment.save
      redirect_to post_path(post)
    else
      redirect_back(fallback_location: root_path)
    end
    
  end

  def destroy
    post = Post.find_by(id: params[:post_id])
    @comment.destroy
    redirect_to post_path(post)
  end

  private
  
  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def correct_user
    unless current_user == @comment.user_id
      redirect_to root_path
    end
  end
end
