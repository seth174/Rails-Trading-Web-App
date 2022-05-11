module Api
  module V1
    class BalancesController < ApplicationController
      protect_from_forgery with: :null_session
      def index
        balances = Balance.all()
        render json: {status: "SUCCESS", message: "Loaded balances", data:balances}, status: :ok
      end

      def show
        balance = User.get_balance(params[:id]) #Dont know if this is right it is not showing the balance from a balance id but the total amount from a user id
        render json: {status: "SUCCESS", message: "Loaded balance", data:balance}, status: :ok
      end

      def create
        balance = Balance.new(balance_params())

        if balance.save
          render json: {status: "SUCCESS", message: "Created new balance", data:balance}, status: :ok
        else
          render json: {status: "ERROR", message: "Balance not saved", data:balance.errors}, status: :unprocessable_entity
        end
      end

      private

      def balance_params()
        params.permit(:amount, :user_id)
      end
    end
  end
end
