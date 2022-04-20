class StocksController < ApplicationController
  include StocksHelper
  TEN_PERCENT = 0.1

  before_action :create_model, only: [:show]

  def show()
    @ticker = params[:ticker].upcase()
    @quote = get_quote(@ticker)

    if @quote[:c] == 0
     flash[:warning] = 'No such stock exist'
     redirect_to current_user
     return
    end
    @days = params.has_key?(:days) ? params[:days] : 30
    graph_max_min = get_stock_history(@ticker, @days)
    @new_graph = graph_max_min[0]
    @max = (graph_max_min[1] + graph_max_min[1] * TEN_PERCENT).round()
    @min = (graph_max_min[2] - graph_max_min[2] * TEN_PERCENT).round()
    @company_profile = get_company_profile(@ticker)
  end

  def create()
    @stock = Stock.new(ticker: params[:ticker].upcase(), name: get_company_profile(params[:ticker])[:name])
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
