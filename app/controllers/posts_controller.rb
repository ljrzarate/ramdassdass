class PostsController < ApplicationController

  def index
    @posts = Post.all#.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
    breadcrumbs.add "All Chapters", chapters_path
    breadcrumbs.add @post.title, post_path(@post)
  end
end
