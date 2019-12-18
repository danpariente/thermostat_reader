class Stats < ApplicationRecord
  include AverageCalculator

  READING_TYPES = %i(
    temperature
    humidity
    battery_charge
  ).freeze

  STATISTIC_TYPES = %w(
    average
    maximum
    minimum
  ).freeze

  self.primary_key = :thermostat_id

  def self.define_reading_types
    READING_TYPES.each do |reading_type|
      define_method("persisted_#{reading_type}") do
        build_stats_for(reading_type)
      end
    end
  end

  def temperature
    current_stats_for("temperature")
  end

  def humidity
    current_stats_for("humidity")
  end

  def battery_charge
    current_stats_for("battery_charge")
  end

  def readonly?
    true
  end

  define_reading_types

  private

  def build_stats_for(reading_type)
    Stats.
      find_by!(thermostat_id: id, stats_type: reading_type).
      attributes.slice(*STATISTIC_TYPES)
  end

  def current_stats_for(reading_type)
    {
      "average" => recalculate_average(thermostat, reading_type, readings_in_queue),
      "maximum" => [send("persisted_#{reading_type}")["maximum"], *fetcher(reading_type)].max,
      "minimum" => [send("persisted_#{reading_type}")["minimum"], *fetcher(reading_type)].min
    }
  end

  def fetcher(reading_type)
    ReadingJobFetcher.new(*readings_in_queue).fetch.map(&reading_type.to_sym) rescue []
  end

  def readings_in_queue
    Range.new(
      thermostat.reload.readings.order(:created_at).last.tracking_number,
      thermostat.reload.readings_count, true
    ).to_a
  end

  def new_reading_sum(reading_type)
    Array(fetcher(reading_type)).sum
  end

  def thermostat
    Thermostat.find(id)
  end

  private_constant :READING_TYPES, :STATISTIC_TYPES
end
