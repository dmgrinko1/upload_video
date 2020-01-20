# frozen_string_literal: true

class BaseApiController < ActionController::API
  include Api::Concerns::ExceptionHandler

  before_action :authorize_request
  attr_reader :current_user

  private

  def authorize_request
    @current_user = AuthorizeApiRequest.new(request.headers).call[:user]
  end
end
