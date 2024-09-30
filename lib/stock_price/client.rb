require "net/http"
require "json"

module StockPrice
  class Client
    BASE_URL = "https://www.alphavantage.co/query"

    def initialize(api_key)
      @api_key = api_key
    end

    def price(symbol)
      get(function: "GLOBAL_QUOTE", symbol: symbol)
    end

    def prices(symbol)
      symbols.map { |symbol| price(symbol) }
    end

    def price_all
      raise "currently not supported"
    end

    private

    def get(params)
      uri = URI(BASE_URL)
      uri.query = URI.encode_www_form(params.merge(apikey: @api_key))
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    end
  end
end
