# frozen_string_literal: true

class User
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  field :username, type: String
  field :auth_token, type: String

  has_many :videos, dependent: :destroy

  validates :username, :auth_token,
            presence: true,
            length: { in: 3..40 }
end
