class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only: [:edit, :update]
 
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
    @user = current_user
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
  
  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to root_path
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
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , flash.now[:alert] = "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end  
end
