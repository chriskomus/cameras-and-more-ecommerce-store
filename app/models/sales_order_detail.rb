class SalesOrderDetail < ApplicationRecord
  has_one :product
  belongs_to :sales_order

  validates :shipped, inclusion: { in: [ true, false ] }
  validates_numericality_of :quantity, only_numeric: true, allow_nil: false
  validates_numericality_of :price, only_numeric: true, allow_nil: false
  # validates :price, presence: true
end
