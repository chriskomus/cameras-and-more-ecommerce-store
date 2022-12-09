class Product < ApplicationRecord
  has_and_belongs_to_many :categories, :join_table => :product_categories

  accepts_nested_attributes_for :categories, allow_destroy: true

  validates :title, presence: true
  validates :sku, presence: true
  validates_numericality_of :price, only_numeric: true, allow_nil: true
  validates_numericality_of :list_price, only_numeric: true, allow_nil: true
  validates_numericality_of :quantity, only_numeric: true, allow_nil: true

  has_one_attached :main_image

  def self.search(search)
    if search
      where(["UPPER(title) LIKE UPPER(?)", "%#{search}%"])
    else
      all
    end
  end
end
