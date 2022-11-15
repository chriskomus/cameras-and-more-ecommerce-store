class SalesOrder < ApplicationRecord
  has_many :sales_order_details

  validates :order_number, presence: true
end
