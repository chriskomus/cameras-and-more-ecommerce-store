class Product < ApplicationRecord
  has_and_belongs_to_many :categories

  validates :title, presence: true
  validates :sku, presence: true
end
