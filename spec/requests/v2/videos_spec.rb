# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Videos V2::API' do
  let(:user) { create(:user) }

  let!(:video) { create(:video, user_id: user.id) }
  let(:id) { video.id }

  let(:with_valid_headers) { valid_headers }
  let(:with_nil_headers) { invalid_headers }
  let(:with_invalid_headers) { invalid_headers_bad_token }

  describe 'GET /api/v2/videos' do
    before { get '/api/v2/videos', params: {}, headers: with_valid_headers }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'JSON body response contains expected video attributes' do
      json_response = JSON.parse(response.body)
      expected_value = ["id", "state", "c_at", "u_at", "duration", "url"]

      expect(json_response[0].keys).to match_array(expected_value)
    end

    it 'returns http status unprocessable_entity if nil token' do
      get '/api/v2/videos', params: {}, headers: with_nil_headers

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns http status unprocessable_entity if not valid token' do
      get '/api/v2/videos', params: {}, headers: with_invalid_headers

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET /api/v2/videos/:id' do
    before { get "/api/v2/videos/#{id}", params: { id: id }, headers: with_valid_headers }
    it 'returns http success' do

      expect(response).to have_http_status(:success)
    end

    it 'JSON body response contains expected video attributes' do
      json_response = JSON.parse(response.body)
      expected_value = ["id", "state", "c_at", "u_at", "duration", "url"]

      expect(json_response.keys).to match_array(expected_value)
    end

    it 'returns http status unprocessable_entity if nil token' do
      get "/api/v2/videos/#{id}", params: { id: id }, headers: with_nil_headers

      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns http status unprocessable_entity if not valid token' do
      get "/api/v2/videos/#{id}", params: { id: id }, headers: with_invalid_headers

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'POST /api/v2/videos/upload' do

    let(:attachment) { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec/support/test_attachment.mp4'))) }
    let(:valid_attributes) { { start_time: 1, end_time: 2, attachment: attachment } }

    context 'when request attributes are valid' do
      before do
        post '/api/v2/videos/upload', params: valid_attributes, headers: with_valid_headers
      end

      it 'returns http success' do
        expect(response).to have_http_status(:created)
      end

      it 'JSON body response contains expected video attributes' do
        json_response = JSON.parse(response.body)
        expected_value = ["id", "state", "c_at", "u_at", "duration", "url"]

        expect(json_response.keys).to match_array(expected_value)
      end
    end

    context 'when an invalid request' do
      before { post '/api/v2/videos/upload', params: valid_attributes, headers: with_invalid_headers }

      it 'returns http status unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'POST /api/v2/videos/:id/failed/retry' do
    let(:attachment) { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec/support/test_attachment.mp4'))) }
    let(:valid_attributes) { { start_time: 1, end_time: 2, attachment: attachment } }

    context 'when request attributes are valid' do
      before do
        video.state = 'failed'
        video.save

        post "/api/v2/videos/#{id}/failed/retry", params: valid_attributes, headers: with_valid_headers
      end

      it 'returns http success' do
        expect(response).to have_http_status(:ok)
      end

    end

    context 'when an invalid request' do
      it 'returns http status unprocessable_entity' do
        post "/api/v2/videos/#{id}/failed/retry", params: valid_attributes, headers: with_invalid_headers

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end