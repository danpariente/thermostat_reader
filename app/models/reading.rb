class Reading < ApplicationRecord
  belongs_to :thermostat

  validates :temperature, :humidity, :battery_charge, presence: true

  acts_as_list scope: :thermostat, column: :tracking_number
end
