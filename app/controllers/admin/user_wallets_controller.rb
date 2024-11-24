module Admin
  class UserWalletsController < ApplicationController
    before_action :authorize_admin

    def update
      wallet = UserWallet.find_by(user_id: params[:user_id])

      if wallet
        amount = params[:amount].to_d
        ActiveRecord::Base.transaction do
          ::Credit.create!(amount: amount, target_wallet: wallet)
          wallet.update!(balance: wallet.balance + amount)
        end
        render json: { wallet: wallet }, status: :ok
      else
        render json: { error: 'Wallet not found' }, status: :not_found
      end
    end
  end
end
