class ToppagesController < ApplicationController
 
  def index
     @posts =Post.all
   if logged_in?
     @posts=current_user.feed_posts.order('created_at DESC').page(params[:page])
     @post=current_user.posts.find_by(id: params[:id])
     @likes_count=Like.where(post_id: @posts.ids).count
    end
  end
end
