class ToppagesController < ApplicationController
  def index
   if logged_in?
     @posts=current_user.feed_posts.order('created_at DESC').page(params[:page])
     @rank = Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
    end
  end
end
