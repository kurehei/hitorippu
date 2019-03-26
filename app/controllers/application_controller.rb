class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper

  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_post =user.posts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
  end
  
  def user_index
    @user_index=User.all
  end
end
