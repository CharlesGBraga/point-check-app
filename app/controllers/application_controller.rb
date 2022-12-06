# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorize_request

  rescue_from CanCan::AccessDenied do |_e|
    render json: { status: 401, message: 'permission denied' }, status: :unauthorized
  end

  # rescue_from ResponseCodeException do |e|
  #   render json: { errors: { status: e.code, message: e.message } }, status: e.code
  # end

  rescue_from ActiveRecord::RecordNotFound do |_e|
    render json: { errors: { status: 404, message: 'not_show' } }, status: :not_found
  end

  def authorize_request
    set_token
    begin
      @decoded = AuthenticationService.new('decode', nil, @token).call

      raise @decoded[:error] if @decoded.has_key?(:error).present?
    rescue StandardError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  private

  def set_token
    @token = request.headers['Authorization']
    @token = @token.split.last if @token
  end

  def current_user
    User.find(@decoded[:id])
  end
end
