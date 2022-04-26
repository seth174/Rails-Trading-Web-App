module UsersHelper
  def get_overview_info(user_id)
    purchased = StocksPurchasedPerPerson.get_stocks_purchased(user_id)
    sold = StocksSoldPerPerson.get_stocks_sold(user_id)
    i = 0
    info = {}
    @stocks = []
    price = 0
    quantity = 0
    different_amounts = 0
    while i < purchased.count()
      info[:ticker] = purchased[i]['ticker']
      stocks_sold = StocksSoldPerPerson.count_stocks_sold(info[:ticker], user_id)
      if StocksPurchasedPerPerson.count_stocks_purchased(info[:ticker], user_id) - stocks_sold == 0
        i += 1
        next
      end
      price += purchased[i]['price'] * purchased[i]['quantity']
      quantity += purchased[i]['quantity']
      while i + 1 < purchased.count() and purchased[i]['ticker'] == purchased[i + 1]['ticker']
        price += purchased[i + 1]['price'] * purchased[i + 1]['quantity']
        quantity += purchased[i + 1]['quantity']
        i += 1
      end
      if stocks_sold > 0
        quantity -= stocks_sold
        price -= StocksPurchasedPerPerson.get_stock_balance(user_id, info[:ticker], stocks_sold)
      end
      current_price = Stock.get_quote(info[:ticker])
      info[:price_per_share] =  price / quantity
      info[:price] = current_price * quantity
      info[:quantity] = quantity
      info[:current_price] = current_price
      info[:percent_change] = (current_price - (price/ quantity)) / (price / quantity) * 100
      info[:net_gain] = current_price * quantity - price
      @stocks.append(info)
      i += 1
      price = 0
      quantity = 0
      info = {}
    end
    @stocks
  end
end
