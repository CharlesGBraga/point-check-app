# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'when db schema' do
    let(:model) { described_class.column_names }

    %w[id name email cpf password_digest created_at updated_at admin].each do |column|
      it { expect(model).to include(column) }
    end
  end

  describe '.have_secure_password' do
    it { is_expected.to have_secure_password }
  end

  describe '.validation' do
    it { is_expected.to validate_length_of(:password).is_at_least(6).is_at_most(20) }

    %w[name email cpf].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end
end
