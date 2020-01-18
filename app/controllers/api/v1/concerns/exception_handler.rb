# frozen_string_literal: true

module Api::V1::Concerns::ExceptionHandler
  include Api::V1::Concerns::Responce
  extend ActiveSupport::Concern

  included do
    rescue_from Mongoid::Errors::DocumentNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end
  end
end
