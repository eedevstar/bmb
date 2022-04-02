class CommentsController < ApplicationController

  def index
    @post = Post.find(params[:post_id])
    @pagy, @comments = pagy(@post.comments, items: 2)
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    redirect_to post_path(@post)
  end

  private
    def comment_params
      params.require(:comment)
        .permit(:body)
        .merge(user_id: current_user.id)
    end
end
