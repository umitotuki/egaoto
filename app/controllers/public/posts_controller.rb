class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if  @post.save
    flash[:notice] = "投稿に成功しました。"
    redirect_to post_path(@post)
    else
    flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end
  
  def index
    @posts = Post.all
  end
  
  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @poat = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿内容を変更しました。"
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "投稿内容を変更できませんでした。"
      render :edit
    end
  end
  # ストロングパラメーター↓
  private
  
  def post_params
    params.require(:post).permit(:user_id, :genre_id, :title, :image, :body, :is_draft)
  end
  
end
