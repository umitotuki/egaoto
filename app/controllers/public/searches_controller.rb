class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @search = params[:search]

    if @model  == "user"
      @records = User.looks(@search)
    else
      @records = Post.looks(@search)
    end
  end
  
  def genre_search
    @genre_id = params[:genre_id]
    @posts = post.where(genre_id: @genre_id)
  end
end
