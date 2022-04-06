module StocksHelper
  require 'finnhub_ruby'
  require 'date'

  SECONDS_IN_DAYS = 86400

  def finnhub_client()
    unless @finnhub_client
      FinnhubRuby.configure do |config|
        config.api_key['api_key'] = 'c78g7iqad3icbce84at0'
      end
      @finnhub_client = FinnhubRuby::DefaultApi.new
    end
    @finnhub_client
  end


  def getStockHistory(ticker, days)
    if(days == '1' or days == '3' or days == '7')
      interval = '30'
    else
      interval = 'D'
    end
    days = days.to_i()
    today = Date.today
    while(today.on_weekend?())
     today = today.prev_day()
    end
    today = today.to_time().to_i()
    start_day = today - days * SECONDS_IN_DAYS

    get_new_graph_max_min(ticker, interval, start_day, today)

  end

  def get_new_graph_max_min(ticker, interval, start_day, today)
    history = finnhub_client().stock_candles(ticker, interval, start_day, today).to_hash

    new_graph = {}
    i = 0
    max = -1
    min = 1_000_000_000

    while i < history[:c].length()
      max =  history[:c][i] > max ? history[:c][i] : max
      min = history[:c][i] < min ? history[:c][i] : min
      time = Time.at(history[:t][i]).to_datetime()
      new_graph[time] = history[:c][i]
      i += 1
    end

    [new_graph, max, min]
  end

end
