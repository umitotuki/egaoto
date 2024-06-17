class Public::SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @model = params[:model]
    @search = params[:search]
    @range = params[:range]
    
    if @model  == "user"
      @records = User.looks(@search, @range)
    else
      @records = Posts.looks(@search, @range)
    end
  end
end
