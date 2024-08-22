class PostsController < ApplicationController

  def index
    @posts = Posts::ByTags.new(tag: params[:tag]).execute if params[:tag].present?
    @posts = @posts.paginate(page: params[:page]).order('created_at DESC')
  end

  def show
    active_record_posts = params[:show_draft].present? ? Post.unpublished : Post.published
    active_record_posts = active_record_posts.order('created_at DESC')
    @post = active_record_posts.friendly.find(params[:id])
    posts = active_record_posts.map.with_index{ |post, index| { index: index, post: post } }

    current_index_post = posts.select { |post| post[:post].id == @post.id }.first[:index]
    @next_post = current_index_post + 1 != posts.size  ? posts[current_index_post + 1][:post] : nil
    @prev_post = current_index_post > 0                ? posts[current_index_post - 1][:post] : nil

    @comments = Comment.where(post_id: @post.id).limit(20).order('created_at DESC')
    breadcrumbs.add "All Chapters", root_path
    breadcrumbs.add @post.title, post_path(@post)
  end

end
