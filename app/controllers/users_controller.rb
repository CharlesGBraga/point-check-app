# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  before_action :unset_current_user_list, only: %i[index]

  load_and_authorize_resource

  # GET /users
  def index
    @users = @q.result.page(params[:page]).per(params[:per_page])
    render json: UserJbuilder.new(@users).call, status: :ok
  end

  # GET /user
  def show
    render json: UserJbuilder.new(@user).call, status: :ok
  end

  # POST /user
  def create
    @user = User.new(user_params.merge(company_id: current_user.company.id))
    if @user.save
      render json: UserJbuilder.new(@user).call, status: :created
    else
      render json: { message: 'not created', error: @user.errors }, status: :unprocessable_entity
    end
  end

  # PUT /user
  def update
    if @user.update(user_params)
      render json: UserJbuilder.new(@user).call, status: :accepted
    else
      render json: { message: 'not created', error: @user.errors }, status: :unprocessable_entity
    end
  end

  # DELETE /user
  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :cpf, :password, :admin, :company_id)
  end

  def unset_current_user_list
    @q = User.where.not(id: current_user.id).ransack(params[:q])
  end
end
