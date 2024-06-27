class Public::ChatsController < ApplicationController
  before_action :block_non_related_users, only: [:show]

  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    if @chat.save
      redirect_to chat_path(params[:user_id])
    else
      @user = User.find(params[:id])
      rooms = current_user.user_rooms.pluck(:room_id)
      user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
      unless user_rooms.nil?
        @room = user_rooms.room
      else
        @room = Room.new
        @room.save
        UserRoom.create(user_id: current_user.id, room_id: @room.id)
        UserRoom.create(user_id: @user.id, room_id: @room.id)
      end
      @chats = @room.chats
      render :show
    end
  end

  def destroy
    @chat = current_user.chats.find(params[:id])
    @chat.destroy
    redirect_to chat_path(@chat)
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def block_non_related_users
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to posts_path
    end
  end
end
