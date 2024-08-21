class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = "Thank you for your comment."
      redirect_to post_path(id: params[:post_id])
    else
      flash[:alert] = @comment.errors.full_messages.to_sentence
      redirect_to "#{post_path(id: params[:post_id], name: params[:name], content: params[:content])}#sayHi"
    end
  end

  private
  def comment_params
    params.permit(:post_id, :name, :content)
  end
end