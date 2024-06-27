class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @model = params[:model]
    @search = params[:search]

    if @model  == "user"
      @records = User.looks(@search)
    else
      @records = Post.looks(@search).where(is_draft: false)
    end
  end
  
  def genre_search
    @genre_id = params[:genre_id]
    @posts = Post.where(genre_id: @genre_id, is_draft: false)
  end
end
