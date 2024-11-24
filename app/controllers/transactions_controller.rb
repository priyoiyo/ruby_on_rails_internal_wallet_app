class TransactionsController < ApplicationController
  def create
    source_wallet = @current_user.user_wallet
    target_user = User.find(params[:target_user_id])
    target_wallet = target_user.user_wallet
    amount = params[:amount].to_d

    if source_wallet.balance >= amount
      ActiveRecord::Base.transaction do
        Transfer.create!(amount: amount, source_wallet: source_wallet, target_wallet: target_wallet)
        source_wallet.update!(balance: source_wallet.balance - amount)
        target_wallet.update!(balance: target_wallet.balance + amount)
      end
      render json: { message: 'Transfer successful' }, status: :ok
    else
      render json: { error: 'Insufficient balance' }, status: :unprocessable_entity
    end
  end
end
