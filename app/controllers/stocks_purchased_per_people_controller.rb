class StocksPurchasedPerPeopleController < ApplicationController

  before_action :check_model, only: [:create]
  before_action :check_balance, only: [:create]

  def new
    if params.has_key?(:ticker)
      @ticker = params[:ticker]
    end
    @purchase = StocksPurchasedPerPerson.new()
  end

  def create
    user = User.find_by(email: current_user().email)
    stock = Stock.find_by(ticker: params[:stock].upcase())
    buying_price = Finnhub::GetQuoteService.call(stock.ticker, false)[MOST_RECENT_PRICE]
    purchase = StocksPurchasedPerPerson.create(user_id: user.id, stock_id: stock.id, quantity: params[:quantity], buying_price: buying_price)

    if purchase.save()
      flash[:success] = "Purchased #{params[:quantity]} stocks of #{stock.name}"

    else
      purchase.errors.full_messages.each() do |e|
        flash[:danger] = e
      end
    end
    redirect_to current_user()
  end

  def index
    date = params.has_key?(:date) ? params[:date] : 5000
    stock_name = params.has_key?(:name) ? params[:name] : " "
    @stocksPurchasedPerPerson = StocksPurchasedPerPerson.find_by_user_id(current_user().id, date, stock_name)
  end

  private

  def check_model()
    if !Stock.find(params[:stock].upcase()).present?()
      flash[:danger] = 'Stock does not exist or you have not visited the stocks page yet'
      redirect_to current_user
      return
    end
  end

  def check_balance()
    if User.get_cash_available(current_user) - Finnhub::GetQuoteService.call(params[:stock], false)[MOST_RECENT_PRICE] * params[:quantity].to_i < 0
      flash[:danger] = 'Inssuficient Funds'
      redirect_to current_user
      return
    end
  end

end
