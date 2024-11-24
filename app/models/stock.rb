class Stock < ApplicationRecord
  belongs_to :user

  validates :symbol, :price, :quantity, presence: true
  validates :price, :quantity, numericality: { greater_than: 0 }
end
