class StocksController < ApplicationController
  include StocksHelper
  def show()
    finnhub = finnhub_client()
    ticker = params[:ticker].to_s().upcase()

     @history = finnhub.stock_candles(ticker, 'D', 1645946782, 1648362382).to_hash
     flash[:success] = ticker
    #  @quote = finnhub.quote(params[:ticker].upcase()).to_hash()
    #  if @quote[:c] == 0
    #    flash[:message] = 'No such stock exist'
    #    redirect_to current_user
    #    return
    # end

  end
end
