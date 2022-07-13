module Api
  module V1
    class StocksSoldPerPeopleController < ApplicationController

      protect_from_forgery with: :null_session
      before_action :check_model, only: [:create]
      before_action :check_quantity, only: [:create]

      def index
        stock = StocksSoldPerPerson.get_stocks_sold(params[:user_id])
        render json: {status: "SUCCESS", message: "Loaded balance", data:stock}, status: :ok
      end

      def create
        if not @model
          render json: {message: "Stock does not exist or page has not been visited"}, status: 400
          return
        end

        if not @quantity
          render json: {message: "You do not have enough stocks to sell "}, status: 400
          return
        end

        user = User.find(params[:user_id])
        stock = Stock.find_by(ticker: params[:stock].upcase())
        selling_price = Finnhub::GetQuoteService.call(stock.ticker, false)[MOST_RECENT_PRICE]
        sale = StocksSoldPerPerson.create(user_id: user.id, stock_id: stock.id, quantity: params[:quantity], selling_price: selling_price)
        render json: selling_price, status: :created
      end

      private

      def check_model()
        if Stock.get_last_update(params[:stock].upcase()) == nil
          @model = false
        else
          @model = true
        end
      end

      def check_quantity
        stocks_owned = Stock.get_stocks_owned(params[:stock].upcase(), params[:user_id])

        if stocks_owned - params[:quantity].to_i < 0
          @quantity = false
        else
          @quantity = true
        end
      end

    end
  end
end
