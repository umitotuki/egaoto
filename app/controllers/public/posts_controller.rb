class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
  
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
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿内容を変更しました。"
      redirect_to post_path(@post)
    else
      flash.now[:alert] = "投稿内容を変更できませんでした。"
      render :edit
    end
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to mypage_path
  end
  # ストロングパラメーター↓
  private
  
  def post_params
    params.require(:post).permit(:user_id, :genre_id, :title, :image, :body, :is_draft)
  end
  
  def is_matching_login_user
    @post = Post.find(params[:id])
    unless @post.user.id == current_user.id
      redirect_to posts_path
    end
  end
  
end
