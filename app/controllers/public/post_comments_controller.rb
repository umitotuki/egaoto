class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    comment = PostComment.new(post_comment_params)
    comment.user_id = current_user.id
    comment.post_id = post.id
    if comment.save
      flash[:notice] = "コメントの投稿に成功しました。"
      redirect_to post_path(post)
    else
      flash.now[:alert] = "コメントの投稿に失敗しました"
      @post = post
      @post_comment = comment 
      render "public/posts/show"
    end
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
