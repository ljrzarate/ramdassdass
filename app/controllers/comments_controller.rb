class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = "Thank you for your comment."
    end
    redirect_to post_path(id: params[:post_id])
  end

  private
  def comment_params
    params.permit(:post_id, :name, :content)
  end
end