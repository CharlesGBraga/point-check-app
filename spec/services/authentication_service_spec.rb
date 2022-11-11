# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticationService, type: :services do
  describe 'when receive user and action' do
    let(:user) { create(:user) }
    let(:exp) { 24.hours.from_now }
    let(:payload) do
      {
        user_id: user.id,
        user_name: user.name,
        user_email: user.email,
        user_cpf: user.cpf,
        user_admin: user.admin,
        exp: exp.to_i
      }
    end
    let(:secret_key) { Rails.application.secrets.secret_key_base }
    let(:token) { JWT.encode(payload, secret_key) }

    it 'then correct params' do
      expect(described_class.new(user, 'encode').call).to eq(token)
    end
  end
end
