# frozen_string_literal: true

class AuthenticationService
  attr_reader :user, :token, :action

  SECRET_KEY = Rails.application.secrets.secret_key_base

  def initialize(action, user = nil, token = nil)
    @action = action
    @user = user
    @token = token
  end

  def call
    if action == 'encode'
      payload = build_payload
      encode_token(payload)
    else
      decode_token(token)
    end
  end

  private

  def build_payload
    {
      id: user.id,
      name: user.name,
      email: user.email,
      cpf: user.cpf,
      admin: user.admin
    }
  end

  def encode_token(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def decode_token(token)
    decoded = JWT.decode(token, SECRET_KEY).first
    ActiveSupport::HashWithIndifferentAccess.new decoded
  end
end
