class Product < ApplicationRecord
  belongs_to :user

  validates :product_name, length: { in: 5..25 }, presence: true
  validates :price, numericality: { greater_than: 0.0 }
  validates :description, presence: true
end
