# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Video, type: :model do
  context 'matchers' do
    describe 'main' do
      it { is_expected.to be_mongoid_document }
      it { is_expected.not_to be_dynamic_document }
    end

    describe 'attributes' do
      it { is_expected.to have_field(:name).of_type(String) }

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
end
