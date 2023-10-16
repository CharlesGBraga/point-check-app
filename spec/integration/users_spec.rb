# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/users', type: :request do
  let(:token) { 'testes' }
  let(:company) { create(:company) }
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

  path '/users' do
    get 'List users' do
      let(:user_count) { rand(1..10) }
      tags 'Users'
      produces 'application/json'
      security [bearer: []]
      parameter name: 'q[name_eq]', in: :query, type: :string, description: 'Search by name', required: false,
                example: 'name'
      parameter name: 'q[cpf_eq]', in: :query, type: :string, description: 'Search by cpf', required: false,
                example: '12345678912'
      parameter name: 'q[admin_eq]', in: :query, type: :string, description: 'Search by admin', required: false,
                example: 'true'

      response '200', 'users found' do
        schema type: :object,
               properties: {
                 data: { type: :array, items: { '$ref' => '#/components/schemas/User' } },
                 included: { type: :array, items: { '$ref' => '#/components/schemas/Company' } },
                 meta: {
                   type: :object,
                   properties: {
                     pagination: { '$ref' => '#/components/schemas/Pagination' }
                   }
                 }
               }
        before do
          create_list(:user, user_count, :unique_items)
        end

        context 'when count users' do
          run_test! do
            expect(json_body['data'].count).to eq(user_count)
          end
        end
      end

      response '401', 'return unauthorized' do
        context 'when unauthorized user access' do
          let(:user_admin) { create(:user, admin: false) }

          run_test! do
            expect(json_body['message']).to eq('permission denied')
          end
        end

        context 'when decode token error' do
          let(:error) { { error: 'Unauthorized' } }

          before do
            allow(authentication_service).to receive(:call).and_return(error)
          end

          run_test!
        end
      end
    end

    post 'Create a user' do
      tags 'Users'
      produces 'application/json'
      consumes 'application/json'
      security [bearer: []]
      description 'Create and manage users'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              name: { type: :string, example: 'João da Silva' },
              email: { type: :string, example: 'example@teste.com' },
              cpf: { type: :string, example: '01201201201' },
              password: { type: :string, example: 'minhasenha**' },
              admin: { type: :boolean, example: true }
            }
          }
        }
      }

      response '201', 'return a user created' do
        schema type: :object,
               properties: {
                 data: { '$ref' => '#/components/schemas/User' },
                 included: { type: :array, items: { '$ref' => '#/components/schemas/Company' } }
               }
        let(:name) { Faker::Name.name }
        let(:email) { Faker::Internet.email }
        let(:cpf) { Faker::CPF.numeric }
        let(:user) do
          {
            user: {
              name: name,
              email: email,
              cpf: cpf,
              password: 'testes',
              admin: false,
              company_id: company.id
            }
          }
        end

        run_test! do
          expect(json_body.dig('data', 'attributes', 'name')).to eq(name)
        end
      end

      response '422', 'Unprocessible Entity' do
        let(:email) { Faker::Internet.email }
        let(:cpf) { Faker::CPF.numeric }
        let(:user) do
          {
            user: {
              name: '',
              email: email,
              cpf: cpf,
              password: 'testes',
              admin: false,
              company_id: company.id
            }
          }
        end
        run_test!
      end
    end
  end

  path '/users/{id}' do
    get 'Show User' do
      tags 'Users'
      produces 'application/json'
      consumes 'application/json'
      description 'Show user'
      security [bearer: []]
      parameter name: :id, in: :path

      response '200', 'success' do
        schema type: :object,
               properties: {
                 data: { items: { '$ref' => '#/components/schemas/User' } },
                 included: { type: :array, items: { '$ref' => '#/components/schemas/Company' } }
               }
        let(:id) { create(:user).id }

        run_test!
      end

      response '404', 'not found' do
        let(:id) { 0 }

        run_test!
      end
    end

    put 'Update User' do
      tags 'Users'
      produces 'application/json'
      consumes 'application/json'
      description 'Update user'
      security [bearer: []]
      parameter name: :id, in: :path
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Jõao da Silva' },
          email: { type: :string, example: 'example@teste.com' },
          cpf: { type: :string, example: '01201201201' },
          password: { type: :string, example: 'testes' },
          admin: { type: :boolean, example: true }
        }
      }

      response '202', 'Updated' do
        schema type: :object,
               properties: {
                 data: { items: { '$ref' => '#/components/schemas/User' } },
                 included: { type: :array, items: { '$ref' => '#/components/schemas/Company' } }
               }
        let(:the_user) { create(:user) }
        let(:id) { the_user.id }
        let(:name) { Faker::Name.name }
        let(:user) do
          {
            user: {
              name: name,
              email: 'example@example.com',
              cpf: '12345678912',
              password: 'testes',
              admin: false,
              company_id: company.id
            }
          }
        end

        context 'when change name' do
          run_test! do
            expect(json_body.dig('data', 'attributes', 'name')).to eq(name)
          end
        end
      end

      response '422', 'Unprocessible Entity' do
        let(:id) { create(:user).id }
        let(:user) do
          {
            user: {
              name: '',
              email: 'example@example.com',
              cpf: '12345678912',
              password: 'testes',
              admin: false,
              company_id: company.id
            }
          }
        end
        run_test!
      end
    end

    delete 'Destroy User' do
      tags 'Users'
      produces 'application/json'
      consumes 'application/json'
      description 'Delete user'
      security [bearer: []]
      parameter name: :id, in: :path, type: :string, description: 'user ID', required: true

      response '204', 'deleted' do
        let(:id) { create(:user).id }
        run_test! do
          expect do
            User.find(id)
          end.to raise_error(ActiveRecord::RecordNotFound)
        end
      end

      response '404', 'not found' do
        let(:id) { 0 }
        run_test!
      end
    end
  end
end
