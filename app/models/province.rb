class Province < ApplicationRecord
  has_many :addresses

  validates :name, presence: true
  validates_numericality_of :hst, only_numeric: true, allow_nil: false
  validates_numericality_of :gst, only_numeric: true, allow_nil: false
  validates_numericality_of :pst, only_numeric: true, allow_nil: false
end
