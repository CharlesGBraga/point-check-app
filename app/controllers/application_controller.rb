class ApplicationController < ActionController::API
  def encode_token(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base.to_s)
  end

  def decode_token(token)
    decoded = JWT.decode(token, Rails.application.secrets.secret_key_base.to_s).first
    HashWithIndifferentAccess.new decoded
  end
end
