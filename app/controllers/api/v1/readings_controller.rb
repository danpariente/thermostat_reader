require "sidekiq/api"

module Api
  module V1
    class ReadingsController < BaseController
      def show
        if reading_processed?
          render json: serializer(reading)
        else
          render json: serializer(fetch_reading)
        end
      end

      def create
        reading = thermostat.readings.new(reading_params)

        if reading.valid?
          collect_data_from_thermostat
          render json: serializer(reading), status: :created
        else
          render json: errors(reading), status: :unprocessable_entity
        end
      end

      private

      def fetch_reading
        ReadingJobFetcher.new(params[:tracking_number]).fetch
      end

      def collect_data_from_thermostat
        ThermostatDataJob.collect(reading_params)
      end

      def serializer(reading)
        ReadingSerializer.new(reading).serialized_json
      end

      def reading
        thermostat.readings.find_by(tracking_number: params[:tracking_number])
      end

      alias_method :reading_processed?, :reading

      def thermostat
        Thermostat.find(params[:thermostat_id])
      end

      def reading_params
        params.require(:reading).
          permit(:temperature, :humidity, :battery_charge).
          merge(
            id: SecureRandom.uuid,
            tracking_number: thermostat.readings_count + 1,
            thermostat_id: thermostat.id
          )
      end
    end
  end
end
