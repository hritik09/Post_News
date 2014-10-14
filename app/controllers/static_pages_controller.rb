class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @post  = current_user.posts.build
      @read_feed_items = Post.all_rows.paginate(page: params[:page])
      @post_count = Post.count
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
