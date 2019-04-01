class UsersController < ApplicationController
 before_action :require_user_logged_in, only: [:index, :show,:edit,:update]
 
  def index
    @users=User.search(params[:search])
  end
  
  def show
     @user=User.find(params[:id])
     @posts=@user.posts.order('created_at DESC')
     counts(@user)
      @followings = @user.followings.page(params[:page])
      @followers =@user.followers.page(params[:page])
  end
 
  def new
    @user=User.new
  end

  
  def create
       @user=User.new(user_params)
     
      if @user.save
        flash[:success] = "登録しました"
        redirect_to @user
      else
        flash.now[:danger] = '失敗しました'
        render :new
      end    

  end
  
  def edit
    @user=User.find(params[:id])
  end
  
  def update
     @user=User.find(params[:id])
     
      if @user.update_attributes(user_params)
        flash[:success] = "変更しました"
        redirect_to @user
      else
        flash.now[:danger] = '変更に失敗しました'
        render :edit
      end

  end
  
  def followings
    @user=User.find(params[:id])
    @count_followings=@user.following.order('created_at DESC')
    counts(@user)
  end
  
  def followers
    @user=User.find(params[:id])
    @count_followers =@user.followers.order('created_at DESC')
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction, :image)
  end
end
