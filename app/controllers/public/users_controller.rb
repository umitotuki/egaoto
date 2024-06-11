class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
     @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def confirm
  end

  def mypage
    @user = current_user
    @posts = @user.posts
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "更新しました。"
      redirect_to mypage_path(@user)
    else
      flash.now[:alert] = "更新できませんでした。"
      render :edit
    end
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :birth, :location, :introduction, :is_active, :image)
  end
  
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
