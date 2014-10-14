class ReadingsController < ApplicationController
  before_action :signed_in_user

  def create
    @newread = current_user.reading.build(params[:reading][:post_id])
    end
  end

end