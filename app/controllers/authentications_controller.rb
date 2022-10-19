class AuthenticationsController < ApplicationController
  def create
    @user = User.find_by(email: login_params[:email])
    if @user && @user.authenticate(login_params[:password])
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
    payload = {
      "user_id": @user.id,
      "admin": @user.admin
    }   
    token = encode_token(payload)
    time = Time.zone.now + 24.hours.to_i

    render json: { 
      name: @user.name, 
      email: @user.email,
      cpf: @user.cpf, 
      exp: time.strftime('%m-%d-%Y %H:%M'), 
      token: token 
    }, status: :created
  end
end
