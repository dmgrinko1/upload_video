# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'matchers' do
    describe 'main' do
      it { is_expected.to be_mongoid_document }
      it { is_expected.not_to be_dynamic_document }
    end

    describe 'attributes' do
      it { is_expected.to have_fields(:username, :auth_token) }

      it { is_expected.to have_field(:username).of_type(String) }
      it { is_expected.to have_field(:auth_token).of_type(String) }

      it { is_expected.to have_timestamps.shortened }
    end

    describe 'associations' do
      it do
        is_expected.to have_many(:videos)
          .with_foreign_key(:user_id)
          .with_dependent(:destroy)
      end
    end

    describe 'validations' do
      it { is_expected.to validate_presence_of(:username) }
      it { is_expected.to validate_presence_of(:auth_token) }

      it { is_expected.to validate_length_of(:username).within(3..40) }
      it { is_expected.to validate_length_of(:auth_token).within(3..40) }
    end
  end
end
