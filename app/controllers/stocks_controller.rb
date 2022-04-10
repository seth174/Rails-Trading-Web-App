class StocksController < ApplicationController
  include StocksHelper
  TEN_PERCENT = 0.1
  def show()
    @ticker = params[:ticker].upcase()
    @days = params[:days]
    @quote = get_quote(@ticker)
    if @quote[:c] == 0
     flash[:warning] = 'No such stock exist'
     redirect_to current_user
     return
    end
    days = params.has_key?(:days) ? params[:days] : 30
    graph_max_min = get_stock_history(@ticker, days)
    @new_graph = graph_max_min[0]
    @max = (graph_max_min[1] + graph_max_min[1] * TEN_PERCENT).round()
    @min = (graph_max_min[2] - graph_max_min[2] * TEN_PERCENT).round()


    @quote = get_quote(@ticker)

    @company_profile = get_company_profile(@ticker)

  end
end
