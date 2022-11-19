# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/authentications', type: :request do
  let(:user) { FatoryBot.create(:user) }
  let(:Authorization) { authentication(token) }
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

  before do
    allow(JWT).to receive(:decode).with(token).and_return({ id: user.id, name: user.name, email: user.email,
                                                            cpf: user.cpf, admin: user.admin, exp: user.exp })
  end

  path '/users' do
    get 'List users' do
      let(:user_count) { rand(1..10) }
      tags 'Users'
      produces 'application/json'
      security [Authorization: []]

      response 200, 'List' do
        schema type: :object,
               properties: {
                 data: { type: :array, items: { '$ref' => '#/components/schemas/User' } },
                 Links: { '$ref' => '#/components/schemas/Pagination' }
               }
        before { create_list(:user, user_count, :unique_items) }

        run_test! do
          expect(json_body['data'].length).to eq(user_count)
        end
      end
    end
  end
end
