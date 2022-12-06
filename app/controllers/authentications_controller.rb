# frozen_string_literal: true

class AuthenticationsController < ApplicationController
  skip_before_action :authorize_request

  def create
    @user = User.find_by(email: login_params[:email])
    if @user&.authenticate(login_params[:password])
      render_json
    else
      render json: { error: 'email or password invalid' }, status: :unprocessable_entity
    end
  end

  private

  def login_params
    params.require(:authentication).permit(:email, :password)
  end

  def render_json
    token = AuthenticationService.new('encode', @user, nil).call
    render json: {
      name: @user.name,
      email: @user.email,
      token: token
    }, status: :created
  end
end
