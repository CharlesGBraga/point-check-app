# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s

  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      components: {
        schemas: {
          Pagination: {
            type: :object,
            properties: {
              current: { type: :integer },
              previous: { type: :integer, nullable: true },
              next: { type: :integer, nullable: true },
              per_page: { type: :integer },
              pages: { type: :integer },
              total_count: { type: :integer }
            }
          },
          User: {
            type: :object,
            properties: {
              id: { type: :integer, example: 1 },
              type: { type: :string, example: 'users' },
              attributes: {
                type: :object,
                properties: {
                  name: { type: :string, example: 'Jõao da Silva' },
                  email: { type: :string, example: 'example@teste.com' },
                  cpf: { type: :string, example: '01201201201' },
                  admin: { type: :boolean, example: 'true' },
                  created_at: { type: :string, example: '2020-04-26T10:20:00.000Z' },
                  updated_at: { type: :string, example: '2020-04-26T10:20:00.000Z' },
                  company_id: { type: :integer, example: 1205 }
                }
              }              
            }
          },
          Company: {
            type: :object,
            properties: {
              id: { type: :integer, example: 1205 },
              type: { type: :string, example: 'company' },
              attributes: {
                type: :object,
                properties: {
                  name: { type: :string, example: 'Empresa SA' },
                  phone: { type: :string, example: '739.412.0117' },
                  cnpj: { type: :string, example: '74865142854440' },
                  created_at: { type: :string, example: '2020-04-26T10:20:00.000Z' },
                  updated_at: { type: :string, example: '2020-04-26T10:20:00.000Z' }
                }
              }
            }
          },
          Point: {
            type: :object,
            properties: {
              id: { type: :integer, example: 1 },
              type: { type: :string, example: 'points' },
              attributes: {
                type: :object,
                properties: {
                  marking: { type: :string, example: '2022-12-16' },
                  marking_type: { type: :string, example: 'going_lunch' },
                  approved: { type: :boolean, example: 'true' },
                  user_id: { type: :integer, example: 1 },
                  created_at: { type: :string, example: '2020-04-26T10:20:00.000Z' },
                  updated_at: { type: :string, example: '2020-04-26T10:20:00.000Z' }
                }
              },
              link: {
                type: :object,
                properties: {
                  link_user: { type: :string, example: 'http://localhost:3000/users/1' } 
                }
              }
            }
          }
        },
        securitySchemes: {
          bearer: {
            type: :http,
            scheme: :bearer
          }
        }
      },
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3000'
            }
          }
        }
      ]
    }
  }

  config.swagger_format = :yaml
end
