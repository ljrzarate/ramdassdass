class PostsController < ApplicationController

  def index
    @posts = Post.paginate(page: params[:page]).order('created_at DESC')
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.where(post_id: @post.id).limit(20).order('created_at DESC')
    breadcrumbs.add "All Chapters", root_path
    breadcrumbs.add @post.title, post_path(@post)
  end
end
