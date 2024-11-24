class User < ApplicationRecord
  has_secure_password

  belongs_to :team, optional: true
  has_one :user_wallet
  has_many :stocks

  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: { in: %w[admin employee] }

  after_create :create_user_wallet

  private

  def create_user_wallet
    UserWallet.create(user: self, balance: 0.0)
  end
end
