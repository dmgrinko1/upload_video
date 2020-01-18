# frozen_string_literal: true

module Api::V1::Concerns::Responce
  def json_response(object, status = :ok)
    render json: object, status: status
  end
end
