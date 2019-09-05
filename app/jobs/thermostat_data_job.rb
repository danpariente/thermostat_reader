class ThermostatDataJob < ApplicationJob
  queue_as :collect_data

  def self.collect(reading_params)
    Thermostat.increment_counter(
      :readings_count, reading_params[:thermostat_id], touch: true
    )

    self.perform_later(reading_params)
  end

  private

  def perform(reading_params)
    Reading.create!(reading_params)
  end
end
