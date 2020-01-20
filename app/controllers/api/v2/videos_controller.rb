# frozen_string_literal: true

class Api::V2::VideosController < BaseApiController
  before_action :set_user
  before_action :set_user_video, only: %i[show retry]

  def index
    json_response(@user.videos)
  end

  def show
    json_response(@video)
  end

  # rubocop:disable  Metrics/MethodLength
  def upload
    @video = @user.videos.new(video_params)
    if @video.save
      json_response(@video, :created)
      if video_params[:start_time].present?
        VideoProcessingJob.perform_later @video.id.to_s
      else
        @video.state = 'done'
        @video.save
      end
    else
      json_response(@video.errors, :unprocessable_entity)
    end
  end
  # rubocop:enable  Metrics/MethodLength

  def retry
    if @video.state == 'scheduler' || @video.state == 'failed'
      VideoProcessingJob.perform_later(@video.id.to_s)
      json_response(@video, :ok)
    else
      json_response({ message: 'Video is processing. could not retry' }, :unprocessable_entity)
    end
  end

  private

  def video_params
    params.permit(:attachment, :start_time, :end_time)
  end

  def set_user
    @user = current_user
  end

  def set_user_video
    @video = Video.find_by!(id: params[:id]) if @user
    raise BaseApiController::NotAuthorized if @video.user_id != @user.id
  end
end
