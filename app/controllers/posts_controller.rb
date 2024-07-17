class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @posts = Post.all
    @post = Post.find(params[:id])
  end
end
