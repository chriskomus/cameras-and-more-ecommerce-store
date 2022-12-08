class SalesOrder < ApplicationRecord
  has_many :sales_order_details
  belongs_to :address
  belongs_to :user

  validates :order_number, presence: true
end
