# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorize_request, :set_current_user, unless: :except_controllers?
  load_and_authorize_resource

  private

  def except_controllers?
    params[:controller] == 'authentications' || 'welcome'
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

  def set_token
    @token = request.headers['Authorization']
    @token = @token.split.last if @token
  end

  def set_current_user
    @current_user = current_user
  end

  def current_user
    User.new(@decoded.merge(token: @token))
  end
end
