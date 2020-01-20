# frozen_string_literal: true

require 'uri'

class VideoSerializer < ActiveModel::Serializer
  attribute :id
  attribute :state
  attribute :c_at, key: :created_at
  attribute :u_at, key: :updated_at
  attribute :duration
  attribute :url

  # TODO: if no end_time and start_time available. Go to VideoProcessingJob and set video range from FFmpeg
  def duration
    return 'In Development' if object.start_time.nil?

    (object.end_time - object.start_time)
  end

  def url
    object.attachment.url(:original, false)
  end

  def id
    object.id.to_s
  end
end
