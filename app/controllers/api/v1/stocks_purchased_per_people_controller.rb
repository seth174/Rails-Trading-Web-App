module Api
  module V1
    class StocksPurchasedPerPeopleController < ApplicationController

      protect_from_forgery with: :null_session

      before_action :check_model, only: [:create]
      before_action :check_balance, only: [:create]

      def index
        stock = StocksPurchasedPerPerson.get_stocks_purchased(params[:user_id])
        render json: {status: "SUCCESS", message: "Loaded balance", data:stock}, status: :ok
      end

      def create
        if not @model
          render json: {message: "Stock does not exist or page has not been visited"}, status: 400
          return
        end
        if not @balance
          render json: {message: "Insufficient funds"}, status: 400
          return
        end

        user = User.find(params[:user_id])
        stock = Stock.find_by(ticker: params[:stock].upcase())
        buying_price = Finnhub::GetQuoteService.call(stock.ticker, false)[MOST_RECENT_PRICE]
        purchase = StocksPurchasedPerPerson.create(user_id: user.id, stock_id: stock.id, quantity: params[:quantity], buying_price: buying_price)
        render json: {status: "SUCCESS", message: "Loaded balance", data:purchase}, status: :created
      end

      private

      def check_model()
        if Stock.get_last_update(params[:stock].upcase()) == nil
          @model = false
        else
          @model = true
        end
      end

      def check_balance()
        return unless @model
        if User.get_cash_available(params[:user_id]) - Finnhub::GetQuoteService.call(params[:stock], false)[MOST_RECENT_PRICE] * params[:quantity].to_i < 0
          @balance = false
        else
          @balance = true
        end
      end

    end
  end
end
