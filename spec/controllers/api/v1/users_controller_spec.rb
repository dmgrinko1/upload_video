# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  context 'includes' do
    it 'are defined' do
      expect(Api::V1::UsersController).to include(Api::Concerns::ExceptionHandler)
      expect(Api::V1::UsersController).to include(Api::Concerns::Responce)
    end
  end

  describe 'before_actions' do
    it { is_expected.to use_before_action(:authenticate_request) }
  end
end
