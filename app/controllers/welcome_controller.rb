# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    render json: 'Welcome to the project - Point Check API', status: :ok
  end
end
