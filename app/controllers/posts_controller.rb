class PostsController < ApplicationController

  def index
    @current_boxes = Shelf.where(slug: params[:tag])

    @current_boxes = Post.where(is_box: true) unless @current_boxes.present?
    @current_box   = @current_boxes.tagged_with(params[:tag]).first
    @current_box   = Post.tagged_with(params[:tag]).first unless @current_box.present?

    @active_posts = Posts::ByTags.new(tag: params[:tag], scope: @active_posts).execute if params[:tag].present?
    @active_posts = @active_posts.paginate(page: params[:page]).order('created_at DESC')
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
