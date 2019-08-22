class Thermostat < ApplicationRecord
  has_secure_token :household_token

  has_many :readings, dependent: :destroy

  validates :household_token, uniqueness: true
end
