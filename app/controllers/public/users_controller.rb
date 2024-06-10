class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
  end

  def show
  end

  def edit
  end

  def confirm
  end

  def mypage
    @user = current_user
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
end
