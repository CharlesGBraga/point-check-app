# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticationService, type: :services do
  describe 'when receive user and action' do
    let(:user) { create(:user) }
    let(:exp) { 24.hours.from_now }
    let(:payload) do
      {
        id: user.id,
        name: user.name,
        email: user.email,
        cpf: user.cpf,
        admin: user.admin,
        exp: exp.to_i
      }
    end
    let(:secret_key) { Rails.application.secrets.secret_key_base }
    let(:token) { JWT.encode(payload, secret_key) }

    it 'then correct params' do
      expect(described_class.new('encode', user, nil).call).to eq(token)
    end
  end
end
