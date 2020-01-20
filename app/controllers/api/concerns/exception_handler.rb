# frozen_string_literal: true

module Api::Concerns::ExceptionHandler
  include Api::Concerns::Responce
  extend ActiveSupport::Concern

  included do
    NotAuthorized = Class.new(StandardError)
    rescue_from BaseApiController::NotAuthorized do
      json_response({ message: 'Forbidden' }, 403)
    end

    rescue_from Mongoid::Errors::DocumentNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end
  end
end
