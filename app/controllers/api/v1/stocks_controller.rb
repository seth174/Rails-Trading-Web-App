module Api
  module V1
    class StocksController < ApplicationController
      def show
        search =  params[:ticker]
        stock = Stock.get(search)
        render json: stock, status: :ok
      end
      def index
        stocks = Stock.all
        render json: stocks, status: :ok
      end

      def stock_graph
        data = StocksController.helpers.get_stock_history(params[:ticker], params[:days])
        render json: data, status: :ok
      end
    end
  end
end
