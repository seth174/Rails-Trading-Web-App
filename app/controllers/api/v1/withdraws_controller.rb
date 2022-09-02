module Api
  module V1
    class WithdrawsController < ApplicationController
      protect_from_forgery with: :null_session
      before_action :check_balance , only: [:create]

      def create()
        unless @newBalance > 0
          render json: 'Inssuficient Funds', status: :bad_request
          return
        end
        withdraw = Withdraw.new(amount: params[:amount], user_id: params[:user_id])
        if(withdraw.save())
          render json: withdraw, status: :ok
        else
          render json: withdraw.errors.full_messages, status: :bad_request
        end
      end

      private

      def check_balance()
        @newBalance = User.get_cash_available(params[:user_id]) + params[:amount]
      end
    end
  end
end
