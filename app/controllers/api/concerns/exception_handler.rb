# frozen_string_literal: true

module Api::Concerns::ExceptionHandler
  include Api::Concerns::Responce
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end
  class NotAuthorized < StandardError; end

  included do
    rescue_from Api::Concerns::ExceptionHandler::NotAuthorized, with: :four_zero_three
    rescue_from Api::Concerns::ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from Api::Concerns::ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from Api::Concerns::ExceptionHandler::InvalidToken, with: :four_twenty_two

    rescue_from Mongoid::Errors::DocumentNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end
  end

  private

  def four_zero_three(exc)
    json_response({ message: exc.message }, :unprocessable_entity)
  end

  def four_twenty_two(exc)
    json_response({ message: exc.message }, :unprocessable_entity)
  end

  def unauthorized_request(exc)
    json_response({ message: exc.message }, :unauthorized)
  end
end
