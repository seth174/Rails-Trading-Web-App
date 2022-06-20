class StocksController < ApplicationController
  include StocksHelper
  TEN_PERCENT = 0.1

  before_action :create_model, only: [:show]

  def show()
    @ticker = params[:ticker].upcase()
    @quote = Finnhub::GetQuoteService.call(@ticker, false)

    @days = params.has_key?(:days) ? params[:days] : 30
    graph_max_min = get_stock_history(@ticker, @days)
    @new_graph = graph_max_min[0]
    @max = (graph_max_min[1] + graph_max_min[1] * TEN_PERCENT).round()
    @min = (graph_max_min[2] - graph_max_min[2] * TEN_PERCENT).round()
    @company_profile = Finnhub::GetCompanyProfileService.call(@ticker)
  end

  def create()
    new_quote = Finnhub::GetQuoteService.call(params[:ticker], true)
    @stock = Stock.new(ticker: params[:ticker].upcase(), name: Finnhub::GetCompanyProfileService.call(params[:ticker])[:name],
    most_recent_price: new_quote[MOST_RECENT_PRICE], day_change: new_quote[DAY_CHANGE], day_percent_change: new_quote[DAY_PERCENT_CHANGE],
    day_high_price: new_quote[DAY_HIGH_PRICE], day_low_price: new_quote[DAY_LOW_PRICE], day_open_price: new_quote[DAY_OPEN_PRICE],
    day_previous_close_price: new_quote[DAY_PREVIOUS_CLOSE_PRICE])
    if @stock.save
       flash[:success] = 'Stock Created Successfully'
    else
      flash[:danger] = 'Stock Does Not Exist'
      redirect_to root_path
    end
  end

  def index()
    @stocks = Stock.all()
  end

  private

  def create_model()
    if(!stock_exist?())
      create()
    end
  end

  def stock_exist?()
    return Stock.exists?(ticker: params[:ticker].upcase())
  end
end
