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
        info = {"min" => data[2], "max" => data[1], "new_graph" => data[0]}
        render json: info , status: :ok
      end

      def company_news
        news = Finnhub::GetCompanyNewsService.call(params[:ticker])
        render json: news, status: :ok
      end
    end
  end
end
