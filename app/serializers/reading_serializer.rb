class ReadingSerializer
  include FastJsonapi::ObjectSerializer

  attributes :tracking_number, :temperature, :humidity, :battery_charge

  belongs_to :thermostat
end
