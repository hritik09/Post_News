class PostsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy, :show]
  before_action :correct_user,   only: :destroy
  respond_to :html, :js

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "post created!"
      redirect_to root_url
    else
      @read_feed_items = Post.all_rows.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_url
  end

  def show
    @reading = Reading.find_or_create_by(user_id: current_user.id, post_id: params[:id])
    @reading.save
    @post_count = Post.count
    @read_count = current_user.read_feed.count
    respond_to do |show|
      show.js {render layout: false}
    end
  end

  def feed

  end

  private

    def post_params
      params.require(:post).permit(:content, :title)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
