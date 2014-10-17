class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @post = Post.find(params[:format])
    @comments = Comment.where(post_id: params[:format])
  end

  # GET /comments/new
  def new
    @post =  Post.find(params[:format])
    @comment = Comment.new
  end


  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(:content => params[:comment][:content], :post_id => params[:comment][:post_id], :user_id => current_user.id)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to '/comments?format='+params[:comment][:post_id], notice: 'Comment was successfully created.' }
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @post_id = @comment.post_id
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url(@post_id) }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :post_id, :user_id)
    end
end
