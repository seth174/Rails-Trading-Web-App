module Api
  module V1
    class StocksPurchasedPerPeopleController < ApplicationController
      def index
        stock = StocksPurchasedPerPerson.get_stocks_purchased(params[:user_id])
        render json: {status: "SUCCESS", message: "Loaded balance", data:stock}, status: :ok
      end
    end
  end
end
