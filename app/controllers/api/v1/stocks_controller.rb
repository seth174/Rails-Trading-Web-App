module Api
  module V1
    class StocksController < ApplicationController
      def show
        stock = Finnhub::GetQuoteService.call(params[:ticker], false)
        render json: {status: "SUCCESS", message: "Loaded balance", data:stock}, status: :ok
      end
    end
  end
end
