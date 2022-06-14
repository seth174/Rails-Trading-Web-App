module Api
  module V1
    class StocksSoldPerPeopleController < ApplicationController
      def index
        data = StocksSoldPerPerson.get_stocks_sold(params[:user_id])
        render json: {status: "SUCCESS", message: "Loaded balance", data:stock}, status: :ok
      end
    end
  end
end
