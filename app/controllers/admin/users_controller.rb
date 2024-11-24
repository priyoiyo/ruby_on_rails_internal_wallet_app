module Admin
  class UsersController < ApplicationController
    before_action :authorize_admin

    def create
      user = User.new(user_params)
    
      if user.save
        render json: { user: user }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      user = User.find(params[:id])

      if user.update(user_params)
        render json: { user: user }, status: :ok
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :role, :team_id)
    end
    
  end
end
