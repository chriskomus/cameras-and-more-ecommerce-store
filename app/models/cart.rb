class Cart < ApplicationRecord
  has_one :product
  has_one :user

  validates_numericality_of :quantity, only_numeric: true, allow_nil: false
end
