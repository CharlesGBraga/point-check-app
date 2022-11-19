# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorize_request, :set_current_user, if: :controller_exclude_list_except?
  load_and_authorize_resource

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

  def controller_exclude_list_except?
    except_controllers = %w[authentications welcome]
    except_controllers.exclude?(params[:controller])
  end

  def set_token
    @token = request.headers['Authorization']
    @token = @token.split.last if @token
  end

  def set_current_user
    @current_user = current_user
  end

  def current_user
    User.new(@decoded.except(:exp))
    # User.new(@decoded.merge(token: @token))
  end
end
