class PostsController < ApplicationController
  def index
    if params[:query].present?
      @posts = Post.search_by_title_and_content(params[:query])
    else
      @posts = Post.all
    end

    respond_to do |format|
      format.html
      format.json { render json: @posts }
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
