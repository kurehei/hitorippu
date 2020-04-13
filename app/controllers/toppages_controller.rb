class ToppagesController < ApplicationController
  def index
   if logged_in?
     @posts=current_user.feed_posts.order('created_at DESC').page(params[:page])
     @rank=Post.joins(:likes).group(:post_id).limit(5).order('count(post_id) desc')
    end
  end
end
