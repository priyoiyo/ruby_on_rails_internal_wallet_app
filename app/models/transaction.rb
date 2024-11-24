class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'UserWallet', optional: true
  belongs_to :target_wallet, class_name: 'UserWallet', optional: true

  validates :amount, numericality: { greater_than: 0 }
  validate :wallets_presence

  private

  def wallets_presence
    case type
    when 'Credit'
      errors.add(:target_wallet, "can't be nil for Credit transactions") if target_wallet.nil?
    when 'Debit'
      errors.add(:source_wallet, "can't be nil for Debit transactions") if source_wallet.nil?
    when 'Transfer'
      if source_wallet.nil? || target_wallet.nil?
        errors.add(:base, "Both source and target wallets must be present for Transfer transactions")
      end
    end
  end
end
