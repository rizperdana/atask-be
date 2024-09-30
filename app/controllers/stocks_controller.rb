class StocksController < ApplicationController
  def show
    client LatestStockPrice::Client.new(ENV["ALPHAVANTAGE_API_KEY"])
    @stock_price = client.price(params[:id])

    if @stock_price["Global Quote"]
      @price = @stock_price["Global Quote"]["05. price"]
      render json: { symbol: params[:id], price: @price }
    else
      render json: { error: "stock not found or api key is missing" }, status: :not_found
    end
  end
end
