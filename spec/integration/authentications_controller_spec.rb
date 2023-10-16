# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe AuthenticationsController do
  let(:password) { Faker::Internet.password(min_length: 8) }
  let(:user) { create(:user, password: password) }

  before do
    allow(Rails.application.secrets).to receive(:secret_key_base).and_return(Faker::Internet.password)
  end

  path '/authentications' do
    post 'Authentication' do
      tags 'Authentications'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :authentication, in: :body, schema: {
        type: :object,
        properties: {
          authentication: {
            type: :object,
            properties: {
              email: { type: :string, example: 'email@gmail.com' },
              password: { type: :string, example: 'minhasenha***' }
            }
          }
        }
      }
      response 201, 'Created token' do
        schema type: :object,
               properties: {
                 name: { type: :string, example: 'Jõao da Silva' },
                 email: { type: :string, example: 'email@gmail.com' },
                 token: { type: :string,
                          example: 'eyJhbGciOiJIUzI1NiJ9.eyJpZCI6NiwibmFtZSI6IkRyLiBHcmVnZyBCZWNrZXIgNyIsImVtYWlsI' }
               }
        let(:authentication_service) { instance_double(AuthenticationService) }
        let(:token) { 'teste' }
        let(:time) { Time.zone.now + 24.hours.to_i }
        let(:expected_response) do
          {
            name: user.name,
            email: user.email,
            token: token
          }
        end

        before do
          allow(AuthenticationService).to receive(:new).with('encode', user, nil).and_return(authentication_service)
          allow(authentication_service).to receive(:call).and_return(token)
        end

        let(:authentication) do
          {
            authentication: {
              email: user.email,
              password: password
            }
          }
        end

        run_test! do
          expect(json_body.to_json).to eq(expected_response.to_json)
        end
      end

      response 422, 'Unprocessable Entity' do
        let(:authentication) do
          {
            authentication: {
              email: user.email,
              password: Faker::Internet.password
            }
          }
        end

        run_test!
      end
    end
  end
end
