# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video, type: :model do
  context 'includes' do
    it 'are defined' do
      expect(Video).to include(Mongoid::Document)
      expect(Video).to include(Mongoid::Timestamps::Short)
      expect(Video).to include(Mongoid::Paperclip)
    end
  end

  context 'enums' do
    describe 'state' do
      it 'creates an enum with valid payment_mode' do
        expected_values = %w[scheduled processing done failed]

        expect(Video.state.values).to contain_exactly(*expected_values)
      end
    end
  end

  context 'matchers' do
    describe 'main' do
      it { is_expected.to be_mongoid_document }
      it { is_expected.not_to be_dynamic_document }
    end

    describe 'attributes' do
      it do
        is_expected.to have_fields(:_id, :c_at, :u_at, :start_time, :end_time, :user_id, :state)
      end

      it 'checks attachment .attachment' do
        is_expected.to have_fields(
          :attachment_file_name,
          :attachment_content_type,
          :attachment_file_size,
          :attachment_updated_at,
          :attachment_fingerprint
        )
      end

      it { is_expected.to have_field(:start_time).of_type(Integer) }
      it { is_expected.to have_field(:start_time).of_type(Integer) }
      it { is_expected.to have_field(:state).of_type(String) }

      it { is_expected.to have_timestamps.shortened }
    end

    describe 'indexes' do
      it { is_expected.to have_index_for(user_id: 1) }
    end

    describe 'associations' do
      it { is_expected.to belong_to(:user).of_type(User) }
    end

    describe 'validations' do
      it { is_expected.to validate_presence_of(:state) }
      it { is_expected.to validate_presence_of(:state) }
      describe '.attachment' do
        it { is_expected.to validate_attachment_presence(:attachment) }
        it {
          is_expected.to validate_attachment_content_type(:attachment)
            .allowing('video/mp4')
            .rejecting('text/plain', 'text/xml')
        }
        it {
          is_expected.to validate_attachment_size(:attachment)
            .less_than(200.megabytes)
        }
      end
    end
  end

  context 'custom' do
    describe 'validations' do
      describe '.attachment' do
        before do
          Video.any_instance.stub(:save_attached_files).and_return(true)
          @attachment = FactoryBot.create :video
        end
      end
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
      describe '.start_time and .end_time' do
        context 'when .start_time and .end_time exists' do
          subject { FactoryBot.create(:video) }

          it { is_expected.to validate_presence_of(:start_time) }
          it { is_expected.to validate_presence_of(:end_time) }
        end

        context 'when both is nil' do
          it 'saves object' do
            video = FactoryBot.create(:video)
            video.start_time = nil
            video.end_time = nil
            video.valid?
            expected_value = true

            expect(video.save).to eq(expected_value)
          end
        end

        context 'when .end_time is nil' do
          it 'not saves with message' do
            video = FactoryBot.create(:video)
            video.start_time = nil
            video.end_time = 0
            video.valid?
            expected_value = "can't be blank"

            expect(video.errors.messages).to eq(start_time: [expected_value])
          end

          context 'when .start_time is nil' do
            it 'not saves with message' do
              video = FactoryBot.create(:video)
              video.start_time = 5
              video.end_time = nil
              video.valid?
              expected_value = "can't be blank"

              expect(video.errors.messages).to eq(end_time: [expected_value])
            end
          end
        end
      end
    end
  end
end
