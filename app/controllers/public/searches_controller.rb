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
end
