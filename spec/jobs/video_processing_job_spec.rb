# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VideoProcessingJob do
  subject { described_class.new.perform(video.id) }
  let(:video) { create :video }

  describe '#perform' do
    context 'when video is valid' do
      it "processes with 'done' .state" do
        subject

        expected_value = 'done'

        expect(video.reload.state).to eq(expected_value)
      end
    end

    context 'when video is not valid' do
      it "processes with 'failed' .state" do
        video.start_time = nil
        video.end_time = nil
        video.save
        subject

        expected_value = 'failed'

        expect(video.reload.state).to eq(expected_value)
      end
    end
  end
end
