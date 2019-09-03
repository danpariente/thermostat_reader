class StatsSerializer
  include FastJsonapi::ObjectSerializer

  attributes :temperature, :humidity, :battery_charge

  belongs_to :thermostat
end
