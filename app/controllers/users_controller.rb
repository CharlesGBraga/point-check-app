# frozen_string_literal: true

class UsersController < ApplicationController
  # GET /users
  def index
    @q = User.all.ransack(params[:q])
    @users = @q.result.page(params[:page]).per(params[:per_page])
    render json: @users, status: :ok
  end

  # def show
  #   @ = .find(params[:id])
  # end

  # def create
  #   @ = .new(params[:])
  # end

  # def update
  #   @ = .find(params[:id])
  # end

  # def edit
  #   @ = .find(params[:id])
  # end

  # def destroy
  #    = .find(params[:id])
  # end
end
