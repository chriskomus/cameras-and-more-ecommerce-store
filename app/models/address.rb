class Address < ApplicationRecord

  validates :name, presence: true
  validates :address_one, presence: true
  validates :city, presence: true
  validates :province, presence: true
  validates :postal_code, presence: true
  validates :country, presence: true
end
