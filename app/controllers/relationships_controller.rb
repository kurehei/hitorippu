class RelationshipsController < ApplicationController
 before_action :require_user_logged_in
 before_action :set_follow

  def create
    current_user.follow(@user)
    redirect_to @user
  end

  def destroy
    current_user.unfollow(@user)
    redirect_to @user
  end

  private

  def set_follow
    @user = User.find(params[:follow_id])
  end
end

