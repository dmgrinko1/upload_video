# frozen_string_literal: true

require 'tmpdir'
# rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Style/RescueStandardError
class VideoProcessingJob < ApplicationJob
  queue_as :default

  def perform(video_id)
    video = Video.find_by(id: video_id)
    return unless video
    return if video.state == 'done' || video.state == 'processing'

    video.state = 'processing'
    video.save
    tmp_file = Dir::Tmpname.create(['tmp', '.mp4']) {}
    begin
      system('ffmpeg',
             '-i', video.attachment.path,
             '-ss', video.start_time.to_s,
             '-t', (video.end_time - video.start_time).to_s,
             '-c', 'copy', tmp_file)
      # FIXME: Better solution here is to apply paperclip save attachment method
      file = Tempfile.new([video.attachment_file_name, '.mp4'])
      file.write(File.read(tmp_file))
      file.rewind

      video.attachment = file
      video.state = 'done'
    rescue => e
      video.state = 'failed'
      logger.fatal e.message
    ensure
      video.save
      File.delete(tmp_file) if File.exist?(tmp_file)
    end
  end
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Style/RescueStandardError
