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
    @customer = current_user
  end
end
