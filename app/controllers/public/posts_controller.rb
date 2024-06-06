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
      render 'new'
    end
  end
  
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end
end
