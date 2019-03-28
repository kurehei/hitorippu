class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy,:rank]
  impressionist :actions => [:show]
  
  def index
    @posts=Post.search(params[:search])
  end
  
  def new
    @post=current_user.posts.build
  end
  
 def show
  @post = Post.find(params[:id])
  @likes_count = Like.where(post_id: @post.id).count
  @comments = @post.comments
  @comment =Comment.new
  impressionist(@post, nil, unique: [:session_hash])
  @user=User.find(params[:id])
 end
 
 def create
    @post=current_user.posts.build(post_params)
    
    if @post.save
      flash[:success]= '記録しました'
      redirect_to root_url
    else
      flash.now[:danger] = '記録できませんでした'
      render :new
    end
  end
   
   def destroy
     @post.destroy
     flash[:danger]='削除しました。'
     redirect_back(fallback_location: root_path)
   end
   
  
   
   private
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
  
  def post_params
    params.require(:post).permit(:name, :content, :image)
  end
  
end
