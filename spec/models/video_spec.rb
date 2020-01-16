# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video, type: :model do
  context 'matchers' do
    describe 'main' do
      it { is_expected.to be_mongoid_document }
      it { is_expected.not_to be_dynamic_document }
    end

    describe 'attributes' do
      it { is_expected.to have_fields(:name, :start_time, :start_time) }

      it { is_expected.to have_field(:name).of_type(String) }

      it { is_expected.to have_field(:start_time).of_type(Integer) }
      it { is_expected.to have_field(:start_time).of_type(Integer) }

      it { is_expected.to have_timestamps.shortened }
    end

    describe 'indexes' do
      it { is_expected.to have_index_for(user_id: 1) }
    end

    describe 'associations' do
      it { is_expected.to belong_to(:user).of_type(User) }
    end

    describe 'validations' do
      it { is_expected.to validate_presence_of(:name) }

      it { is_expected.to validate_length_of(:name).within(3..50) }
    end
  end

  context 'custom' do
    describe 'validations' do
      describe '#end_time_after_start_time' do
        it 'saves object' do
          video = FactoryBot.create(:video)
          video.start_time = 1
          video.end_time = 2
          expected_value = true

          expect(video.save).to eq(expected_value)
        end

        it 'not saves with message' do
          video = FactoryBot.create(:video)
          video.start_time = 2
          video.end_time = 1
          video.valid?
          expected_value = 'must be after the start time'

          expect(video.errors.messages).to eq(end_date: [expected_value])
        end
      end
    end
  end
end
