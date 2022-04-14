class StocksPurchasedPerPeopleController < ApplicationController

  before_action :check_model, only: [:create]
  before_action :check_balance, only: [:create]

  def new
    if params.has_key?(:ticker)
      @ticker = params[:ticker]
    end
    @purchase = StocksPurchasedPerPerson.new()
    user = current_user()
    @options = {user.name => user.id}
  end

  def create
    user = User.find_by(email: current_user().email)
    stock = Stock.find_by(ticker: params[:stock].upcase())
    buying_price = get_price(stock.ticker)
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
    @stocksPerPerson = StocksPurchasedPerPerson.find_by_user_id(current_user().id)
  end

  private

  def get_price(ticker)
    get_quote(ticker)[:c]
  end

  def check_model()
    if !Stock.find(params[:stock].upcase()).present?()
      flash[:danger] = 'Stock does not exist or you have not visited the stocks page yet'
      redirect_to current_user
      return
    end
  end

  def check_balance()
    if User.get_cash_available(current_user) - get_quote(params[:stock])[:c] < 0
      flash[:danger] = 'Inssuficient Funds'
      redirect_to current_user
      return
    end
  end

end
