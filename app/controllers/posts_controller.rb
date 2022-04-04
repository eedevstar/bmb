class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @pagy, @posts = pagy(Post.all, items: 10)
    @post = Post.new
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_url }
        format.json { render :show, status: :created, location: @post }
      else
        format.turbo_stream { # route turbo_stream validation errors
          render turbo_stream: turbo_stream.replace(
                  @post, partial: "posts/modal_form",
                  locals: { post: @post}) }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    @post.update(post_params)
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, status: 303 }
      format.json { head :no_content }
      # format.turbo_stream { turbo_stream.remove @post }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post)
        .permit(:title, :body)
        .merge(user_id: current_user.id)
    end
end
