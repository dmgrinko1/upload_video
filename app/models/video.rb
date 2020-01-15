# frozen_string_literal: true

class Video
  include Mongoid::Document
  include Mongoid::Timestamps::Short

  field :name, type: String

  belongs_to :user, index: true

  index({ user_id: 1 }, unique: true)

  validates :name,
            presence: true,
            length: { in: 3..50 }
end
