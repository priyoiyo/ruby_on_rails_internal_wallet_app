require Rails.root.join('lib', 'latest_stock_price', 'client.rb')

class StocksController < ApplicationController
  before_action :authenticate_user 

  # Fetch all stock prices from the external API
  def price_all
    client = LatestStockPrice::Client.new
    stock_prices = client.price_all
    render json: stock_prices, status: :ok
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  # Buy stock using the fetched stock prices
  def create
    symbol = params[:symbol]
    quantity = params[:quantity].to_i

    client = LatestStockPrice::Client.new
    stock_prices = client.price_all
    stock_data = stock_prices.find { |stock| stock['symbol'] == symbol }

    if stock_data.nil?
      render json: { error: 'Invalid stock symbol' }, status: :unprocessable_entity
      return
    end

    price = stock_data['lastPrice'].to_d
    total_cost = price * quantity

    wallet = @current_user.user_wallet

    if wallet.balance >= total_cost
      ActiveRecord::Base.transaction do
        wallet.update!(balance: wallet.balance - total_cost)
        Stock.create!(user: @current_user, symbol: symbol, price: price, quantity: quantity)
      end
      render json: { message: 'Stock purchased successfully', balance: wallet.balance }, status: :ok
    else
      render json: { error: 'Insufficient balance' }, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: { error: 'Failed to purchase stock', details: e.message }, status: :unprocessable_entity
  end
end
