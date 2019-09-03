class Stats < ApplicationRecord
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
      define_method(reading_type) do
        build_stats_for(reading_type)
      end
    end
  end

  def readonly?
    true
  end

  define_reading_types

  private

  def build_stats_for(reading_type)
    Stats.
      find_by!(stats_type: reading_type).
      attributes.slice(*STATISTIC_TYPES)
  end

  private_constant :READING_TYPES, :STATISTIC_TYPES
end
