class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index

  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to admin_top_path
  end
end
