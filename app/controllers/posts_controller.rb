class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @posts=Post.search(params[:name])
  end
  
  def new
    @post= Post.new
  end
  
 def show
  @post = Post.find(params[:id])
  @likes_count = Like.where(post_id: @post.id).count
  @comments = @post.comments
  @comment =Comment.new
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
     redirect_to root_url
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
