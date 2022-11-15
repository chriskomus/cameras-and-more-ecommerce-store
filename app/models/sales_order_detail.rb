class SalesOrderDetail < ApplicationRecord
  has_one :product
  belongs_to :sales_order

  validates :quantity, presence: true
  validates :price, presence: true
end
