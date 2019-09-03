class Stats
  READING_TYPES = %i(
    temperature
    humidity
    battery_charge
  ).freeze

  def initialize(thermostat)
    @thermostat = thermostat
  end

  def self.define_reading_types
    READING_TYPES.each do |reading_type|
      define_method(reading_type) do
        build_stats_hash_for(reading_type)
      end
    end
  end

  def thermostat_id
    thermostat.id
  end

  alias :id :thermostat_id

  define_reading_types

  private

  attr_reader :thermostat

  def build_stats_hash_for(reading_type)
    %i(average maximum minimum).each_with_object({}) do |stat, hash|
      hash[stat] = send(stat, reading_type)
    end
  end

  def average(reading_type)
    readings.average(reading_type).to_f
  end

  def maximum(reading_type)
    readings.maximum(reading_type)
  end

  def minimum(reading_type)
    readings.minimum(reading_type)
  end

  def readings
    thermostat.readings
  end
end
