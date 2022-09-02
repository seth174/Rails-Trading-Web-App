module Api
  module V1
    class DepositsController < ApplicationController
      protect_from_forgery with: :null_session
      def create()
        deposit = Deposit.new(amount: params[:amount], user_id: params[:user_id])
        if(deposit.save())
          render json: deposit, status: :ok
        else
          render json: deposit.errors.full_messages, status: :bad_request
        end
      end
    end
  end
end
