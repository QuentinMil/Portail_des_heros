# app/controllers/posts_controller.rb
class PostsController < ApplicationController
  def index
    @posts = if params[:query].present?
               Post.search_by_title(params[:query])
             else
               Post.all
             end.order(:title)

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: 'posts/list', formats: [:html], locals: { posts: @posts } }
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
