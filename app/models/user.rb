# frozen_string_literal: true

class User
  include Mongoid::Document
  include Mongoid::Timestamps::Short
  include ActiveModel::SecurePassword

  field :email,           type: String
  field :password,        type: String
  field :password_digest, type: String

  has_secure_password

  has_many :videos, dependent: :destroy

  validates :email,
            presence: true,
            length: { in: 3..40 },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password_digest,
            presence: true,
            length: { in: 3..72 }
end
