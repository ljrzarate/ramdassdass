class PostsController < ApplicationController

  def index
    @posts = Post.paginate(page: params[:page]).order('created_at DESC')
    @posts = if params[:show_draft]
               @posts = @posts.unpublished
             else
               @posts = @posts.published
             end

  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.where(post_id: @post.id).limit(20).order('created_at DESC')
    breadcrumbs.add "All Chapters", root_path
    breadcrumbs.add @post.title, post_path(@post)
  end
end
