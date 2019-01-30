class CommentsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @comment=Comment.new(comment_params)
    
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
    
  end

  def destroy
  end
  private
  
  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end
end
