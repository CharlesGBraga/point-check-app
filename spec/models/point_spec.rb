# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Point, type: :model do
  describe 'when db schema' do
    let(:model) { described_class.column_names }

    %w[id marking marking_type approved user_id deleted_at ].each do |column|
      it { expect(model).to include(column) }
    end
  end

  describe '.validation' do
    %w[marking marking_type].each do |field|
      it { is_expected.to validate_presence_of(field) }
    end
  end

  describe '.associations' do
    it { is_expected.to belong_to(:user) }
  end
end
