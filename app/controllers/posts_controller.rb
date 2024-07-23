class PostsController < ApplicationController
  def index
    @posts = Post.all

    if params[:query].present?
      @posts = @posts.where('title ILIKE ?', "%#{params[:query]}%")
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
