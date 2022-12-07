# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'when db schema' do
    let(:model) { described_class.column_names }

    %w[id name phone cnpj created_at updated_at].each do |column|
      it { expect(model).to include(column) }
    end
  end

  describe '.associations' do
    it { is_expected.to have_many(:users).dependent(:destroy) }
  end
end
