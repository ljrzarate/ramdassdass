class CommentsController < ApplicationController
  before_action :set_post

  def create
    common_params = { name: params[:name], content: params[:content] }
    link_with_params =  if params[:show_draft].present?
                          post_path(@post.friendly_id, { show_draft: true }.merge(common_params))
                        else
                          post_path(@post.friendly_id, common_params)
                        end

    @comment = Comment.new(comment_params.merge({post_id: @post.id}))
    if @comment.save
      flash[:success] = "Thank you for your comment."
      redirect_to link_with_params
    else
      flash[:alert] = @comment.errors.full_messages.to_sentence
      redirect_to "#{link_with_params}#sayHi"
    end
  end

  private

  def set_post
    @post = @active_posts.friendly.find(params[:post_id])
  end

  def set_comment

  end

  def comment_params
    params.permit(:name, :content)
  end
end