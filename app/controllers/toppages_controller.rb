class ToppagesController < ApplicationController
 
  def index
     @posts =Post.all
   if logged_in?
     @posts=current_user.feed_posts.order('created_at DESC').page(params[:page])
     @post=current_user.posts.find_by(id: params[:id])
     @users = User.order(' created_at DESC')
     @rank=Post.find(Like.group(:post_id).order('count(post_id) desc').limit(5).pluck(:post_id))
    end
  end
end
