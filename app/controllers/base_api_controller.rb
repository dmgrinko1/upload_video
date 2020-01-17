# frozen_string_literal: true

class BaseApiController < ActionController::API
  before_action :authenticate

  private

  def authenticate
    head(401) unless User.where(auth_token: request.headers['X-Auth-Token']).exists?
  end
end
