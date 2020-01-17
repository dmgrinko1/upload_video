# frozen_string_literal: true

class Api::V1::VideosController < BaseApiController
  def index
    @videos = User.last.videos

    render json: @videos, status: :ok
  end

  def show
    @video = User.last.videos.find(params[:id])

    render json: @video, status: :ok
  end

  def upload
    @video = User.last.videos.new(video_params)
    if @video.save
      render json: @video, status: :created
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end

  def retry
    render json: 'this is stub', status: :ok
  end

  private

  def video_params
    params.permit(:attachment, :start_time, :end_time)
  end
end
