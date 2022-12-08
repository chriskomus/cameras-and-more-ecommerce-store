class Address < ApplicationRecord
  has_and_belongs_to_many :users, :join_table => :addresses_users
  belongs_to :province
  has_many :sales_order

  validates :name, presence: true
  validates :address_one, presence: true
  validates :city, presence: true
  validates :postal_code, presence: true
  validates :country, presence: true
end
