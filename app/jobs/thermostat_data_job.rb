class ThermostatDataJob < ApplicationJob
  queue_as :collect_data

  def self.collect(thermostat, reading_params)
    self.perform_later(thermostat, reading_params)
  end

  private

  def perform(thermostat, reading_params)
    thermostat.readings.create!(reading_params)
  end
end
