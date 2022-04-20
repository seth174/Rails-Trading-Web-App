class StocksSoldPerPeopleController < ApplicationController
  before_action :check_model, only: [:create]
  before_action :check_model, only: [:create]

  def new()
    if params.has_key?(:ticker)
      @ticker = params[:ticker]
    end
    @sold = StocksSoldPerPerson.new()
  end

  def index
    @stocksSoldPerPerson = StocksSoldPerPerson.find_by_user_id(current_user().id)
  end

  def create
    user = User.find_by(email: current_user().email)
    stock = Stock.find_by(ticker: params[:stock].upcase())
    selling_price = Stock.get_price(stock.ticker)
    sale = StocksSoldPerPerson.create(user_id: user.id, stock_id: stock.id, quantity: params[:quantity], selling_price: selling_price)

    if sale.save()
      flash[:success] = "Sold #{params[:quantity]} stocks of #{stock.name}"

    else
      sale.errors.full_messages.each() do |e|
        flash[:danger] = e
      end
    end
    redirect_to current_user()
  end

  private

  def check_model()
    if !Stock.find(params[:stock].upcase()).present?()
      flash[:danger] = 'Stock does not exist or you have not visited the stocks page yet'
      redirect_to current_user
      return
    end
  end

  def check_quantity()
    if
      flash[:danger] = 'Stock does not exist or you have not visited the stocks page yet'
      redirect_to current_user
      return
    end
  end

end
