# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V2::VideosController, type: :controller do
  context 'includes' do
    it 'are defined' do
      expect(Api::V2::VideosController).to include(Api::Concerns::ExceptionHandler)
      expect(Api::V2::VideosController).to include(Api::Concerns::Responce)
    end
  end

  describe 'before_actions' do
    it { is_expected.to use_before_action(:authorize_request) }
    it { is_expected.to use_before_action(:set_user) }
    it { is_expected.to use_before_action(:set_user_video) }
  end
end
