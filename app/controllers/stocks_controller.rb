class StocksController < ApplicationController
  include StocksHelper
  TEN_PERCENT = 0.1
  def show()
    finnhub = finnhub_client()
    @ticker = params[:ticker].upcase()
    @days = params[:days]
    @info = finnhub.quote(@ticker).to_hash
    days = params.has_key?(:days) ? params[:days] : 30
    graph_max_min = getStockHistory(@ticker, days)
    @new_graph = graph_max_min[0]
    @max = (graph_max_min[1] + graph_max_min[1] * TEN_PERCENT).round()
    @min = (graph_max_min[2] - graph_max_min[2] * TEN_PERCENT).round()
    if @info[:c] == 0
     flash[:message] = 'No such stock exist'
     redirect_to current_user
    end

  end
end
