# app/controllers/api/v1/users_controller.rb

module Api
  module V1
    class UsersController < ApplicationController
      before_action :set_user, only: [ :show, :update, :destroy ]

      def index
        @users = User.all
        render json: @users
      end

      def show
        render json: @user
      end

      def create
        @user = User.new(user_params)

        return render json: @user if @user.save

        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end

      def update
        return render json: @user if @user.update(user_params)

        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end

      def destroy
        @user.destroy
        render json: :no_content
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :role)
      end
    end
  end
end
