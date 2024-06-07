class Public::PostsCommentController < ApplicationController
  before_action :authenticate_user!
end
