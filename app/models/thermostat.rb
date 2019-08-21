class Thermostat < ApplicationRecord
  has_secure_token :household_token

  validates :household_token, presence: true, uniqueness: true
end
