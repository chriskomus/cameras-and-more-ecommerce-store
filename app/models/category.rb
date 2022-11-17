class Category < ApplicationRecord
  has_and_belongs_to_many :products, :join_table => :product_categories

  validates :title, presence: true
end
