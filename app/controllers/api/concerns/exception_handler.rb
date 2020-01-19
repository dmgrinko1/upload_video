# frozen_string_literal: true

module Api::Concerns::ExceptionHandler
  include Api::Concerns::Responce
  extend ActiveSupport::Concern

  included do
    rescue_from Mongoid::Errors::DocumentNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end
  end
end
