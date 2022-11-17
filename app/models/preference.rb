class Preference < ApplicationRecord
  validates :setting, presence: true
end
