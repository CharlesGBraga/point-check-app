# frozen_string_literal: true

class WelcomeController < ApplicationController
  skip_before_action :authorize_request

  def index
    render json: 'Welcome to the project - Point Check API', status: :ok
  end
end
