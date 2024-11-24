class UsersController < ApplicationController
    def profile
      render json: { user: @current_user }, status: :ok
    end
  end
  