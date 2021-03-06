class CommentsController < ApplicationController
  before_action :get_post

  def index
    @comments = @post.comments
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.new(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_comments_url @post }
        format.json { render :show, status: :created, location: @comment }
      else
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
                  @comment, partial: 'comments/form',
                  locals: { post: @post, comment: @comment }) }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def get_post
      @post = Post.find params[:post_id]
    end

    def comment_params
      params.require(:comment)
        .permit(:body)
        .merge(user_id: current_user.id)
    end
end
