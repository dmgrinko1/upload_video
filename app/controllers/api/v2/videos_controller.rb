# frozen_string_literal: true

class Api::V2::VideosController < BaseApiController
  before_action :set_user
  before_action :set_user_video, only: [:show]

  def index
    json_response(@user.videos)
  end

  def show
    json_response(@video)
  end

  def upload
    @video = @user.videos.new(video_params)
    if @video.save
      json_response(@video, :created)
    else
      json_response(@video.errors, :unprocessable_entity)
    end
  end

  def retry
    render json: 'this is stub', status: :ok
  end

  private

  def video_params
    params.permit(:attachment, :start_time, :end_time)
  end

  def set_user
    @user = User.last
  end

  def set_user_video
    @video = @user.videos.find_by!(id: params[:id]) if @user
  end
end
