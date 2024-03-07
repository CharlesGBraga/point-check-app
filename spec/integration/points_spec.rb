# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Points' do
  let(:token) { 'testes' }
  let(:user_admin) { create(:user, admin: true) }
  let(:payload) do
    {
      id: user_admin.id,
      name: user_admin.name,
      email: user_admin.email,
      cpf: user_admin.cpf,
      admin: user_admin.admin,
      exp: 1.hour.from_now.to_i
    }
  end
  let(:Authorization) { authentication(token) }
  let(:authentication_service) { instance_double(AuthenticationService) }

  before do
    allow(AuthenticationService).to receive(:new).with('decode', nil, token).and_return(authentication_service)
    allow(authentication_service).to receive(:call).and_return(payload)
  end

  path '/points' do
    get 'List points' do
      let(:point_count) { rand(1..10) }
      tags 'Points'
      produces 'application/json'
      security [bearer: []]
      parameter name: 'q[user_id_eq]', in: :query, type: :integer, description: 'Search by user id', required: false,
                example: 1
      parameter name: 'q[created_at_gteq]', in: :query, type: :string, description: 'Search created at from',
                required: false, example: '2022-12-16'
      parameter name: 'q[created_at_lteq]', in: :query, type: :string, description: 'Search created at until',
                required: false, example: '2022-12-16'

      response '200', 'users found' do
        schema type: :object,
               properties: {
                 data: { type: :array, items: { '$ref' => '#/components/schemas/Point' } },
                 included: { type: :array, items: { '$ref' => '#/components/schemas/User' } },
                 meta: {
                   type: :object,
                   properties: {
                     pagination: { '$ref' => '#/components/schemas/Pagination' }
                   }
                 }
               },
               required: %w[data included meta]
        before do
          create_list(:point, point_count, :unique_items)
        end

        context 'when count points' do
          run_test! do
            expect(json_body['data'].count).to eq(point_count)
          end
        end
      end

      response '401', 'return unauthorized' do
        context 'when decode token error' do
          let(:error) { { error: 'Unauthorized' } }

          before do
            allow(authentication_service).to receive(:call).and_return(error)
          end

          run_test!
        end
      end
    end

    post 'Create a point' do
      tags 'Points'
      produces 'application/json'
      consumes 'application/json'
      security [bearer: []]
      description 'Create and manage points'
      parameter name: :point, in: :body, schema: {
        type: :object,
        properties: {
          point: {
            type: :object,
            properties: {
              marking: { type: :string, example: '2022-12-10T19:35:00.000Z' },
              marking_type: { type: :string, example: 'return_lunch' }
            }
          }
        }
      }

      response '201', 'return a point created' do
        schema type: :object,
               properties: {
                 data: { '$ref' => '#/components/schemas/Point' },
                 included: { type: :array, items: { '$ref' => '#/components/schemas/User' } }
               }
        let(:marking) { '2022-12-10T19:35:00.000Z' }
        let(:point) do
          {
            point: {
              marking: marking,
              marking_type: 'return_lunch'
            }
          }
        end

        run_test! do
          expect(json_body.dig('data', 'attributes', 'marking')).to eq(marking)
        end
      end
    end
  end
end
