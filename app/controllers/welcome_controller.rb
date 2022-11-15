# frozen_string_literal: true

class WelcomeController < ApplicationController
  skip_load_and_authorize_resource

  def index
    render json: 'Welcome to the project - Point Check API', status: :ok
  end
end
