# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'includes' do
    it 'are defined' do
      expect(User).to include(Mongoid::Document)
      expect(User).to include(Mongoid::Timestamps::Short)
      expect(User).to include(ActiveModel::SecurePassword)
    end
  end

  context 'matchers' do
    describe 'main' do
      it { is_expected.to be_mongoid_document }
      it { is_expected.not_to be_dynamic_document }
    end

    describe 'attributes' do
      it { is_expected.to have_fields(:email, :password, :password_digest) }

      it { is_expected.to have_field(:email).of_type(String) }
      it { is_expected.to have_field(:password).of_type(String) }
      it { is_expected.to have_field(:password_digest).of_type(String) }

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
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:password_digest) }

      it { is_expected.to validate_length_of(:email).within(3..40) }
      it { is_expected.to validate_length_of(:password_digest).within(3..72) }
    end
  end
end
