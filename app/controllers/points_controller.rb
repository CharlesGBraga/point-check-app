# frozen_string_literal: true

class PointsController < ApplicationController
  before_action :set_point, only: %i[show update destroy]
  before_action :set_points, only: :index

  load_and_authorize_resource

  # GET /points
  def index
    @points = @q.result.page(params[:page]).per(params[:per_page])
    render json: PointJbuilder.new(@points).call, status: :ok
  end

  # GET /point/id
  def show
    render json: PointJbuilder.new(@point).call, status: :ok
  end

  # POST /point
  def create
    @point = Point.new(point_params.merge(user_id: current_user.id))
    if @point.save
      render json: PointJbuilder.new(@point).call, status: :created
    else
      render json: { message: 'not created', error: @point.errors }, status: :unprocessable_entity
    end
  end

  # PUT /point/id
  def update
    if @point.update(point_params)
      render json: PointJbuilder.new(@point).call, status: :accepted
    else
      render json: { message: 'not created', error: @point.errors }, status: :unprocessable_entity
    end
  end

  # DELET /point/id
  def destroy
    @point.destroy
    head :no_content
  end

  private

  def set_points
    @q = Point.accessible_by(current_ability).ransack(params[:q])
  end

  def set_point
    @point = Point.find(params[:id])
  end

  def point_params
    params.require(:point).permit(:marking, :marking_type, :approved, :user_id)
  end
end
