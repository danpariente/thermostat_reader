module AverageCalculator
  include ActiveSupport::Concern

  def recalculate_average(thermostat, reading_type, readings_in_queue)
    return current_average(reading_type) if synchronized?(readings_in_queue)

    (recalculated_sum(reading_type) / total_readings_count).to_f.round(2)
  end

  private

  def current_average(reading_type)
    send("persisted_#{reading_type}")["average"]
  end

  def synchronized?(readings_in_queue)
    readings_in_queue.size.zero?
  end

  def recalculated_sum(reading_type)
    (current_average(reading_type) * persisted_readings_count) + new_reading_sum(reading_type)
  end

  def persisted_readings_count
    total_readings_count - readings_in_queue.size
  end

  def total_readings_count
    thermostat.reload.readings_count
  end
end
