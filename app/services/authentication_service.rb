# frozen_string_literal: true

class AuthenticationService
  attr_reader :user, :action

  SECRET_KEY = Rails.application.secrets.secret_key_base

  def initialize(user, action)
    @action = action
    @user = user
  end

  def call
    return unless action == 'encode'

    payload = build_payload
    encode_token(payload)
  end

  private

  def build_payload
    {
      user_id: user.id,
      user_name: user.name,
      user_email: user.email,
      user_cpf: user.cpf,
      user_admin: user.admin
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
