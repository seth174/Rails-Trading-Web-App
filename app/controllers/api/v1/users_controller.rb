module Api
  module V1
    class UsersController < ApplicationController
      before_action :check_user_id , only: [:get_balance]

      def index
        users = User.all()
        render json: {status: "SUCCESS", message: "Loaded users", data:users}, status: :ok
      end

      def show
        user = User.find_by(email: params[:email].downcase)
        if user && user.authenticate(params[:password])
          render json: user, status: :ok
        else
          render json: nil, status: :unauthorized
        end
      end

      def get_stocks_owned_info
        info = ApplicationController.helpers.get_overview_info(params[:user_id])
        if info
          render json: info, status: :ok
        else
          render json: {message: "something went wrong", status: :error}
        end
      end

      def get_balance
        balance = User.get_balance(params[:user_id])
        render json: balance, status: :ok
      end


      private

      def check_user_id()
        unless(User.exists?(params[:user_id]))
          render json: {message: "something went wrong", status: :error}
        end
      end

      def balance_params()
        params.permit(:amount, :user_id)
      end

      def overview_params()
        params.permit( :user_id)
      end
    end
  end
end
