# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  def index
    if params[:query].present?
      @posts = Post.where("title ILIKE ?", "%#{params[:query]}%")
    else
      @posts = Post.all
    end

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'posts/list', locals: { posts: @posts } }
    end
  end

  def show
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: { title: @post.title, content: @post.content } }
    end
  end
end
