# frozen_string_literal: true

class VideoSerializer < ActiveModel::Serializer
  attributes :id, :state, :c_at, :u_at

  attribute :duration
  attribute :url

  def duration
    object.end_time - object.start_time
  end

  def url
    object.attachment.url(:original, false)
  end
end
