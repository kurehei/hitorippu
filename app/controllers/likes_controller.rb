class LikesController < ApplicationController
  before_action :set_like, only: [:destroy]
  
  def create
    @like = current_user.likes.build(like_params)
    @post = @like.post
    @likes_count = Like.where(post_id: @post.id).count  # ← 追加
    if @like.save
      respond_to :js
    end
  end

  def destroy
    @post = @like.post
    @likes_count = Like.where(post_id: @post.id).count  # ← 追加
    if @like.destroy
      respond_to :js
    end
  end
  
  private
  
  def like_params
    params.permit(:post_id)
  end

  def set_like
    @like = Like.find(params[:id])
  end
end
